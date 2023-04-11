require 'exceptions.rb'
require "uri"
require "net/http"
module OrdersHelper
  def distance(loc1, loc2)
    rad_per_deg = Math::PI/180
    earth_radius = 6371             
  
    dlat = (loc2[0]-loc1[0]) * rad_per_deg 
    dlon = (loc2[1]-loc1[1]) * rad_per_deg
  
    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
  
    a = Math.sin(dlat/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  
    (earth_radius * c).round(1) 
  end

  def create_params(params)
    now=Time.now
    order_total=0
    params[:id] = Order.generate_id(now.to_i)
    params[:order_time] = now
    params[:status]="unpaid"
    params[:order_details_attributes].each do |n|  
      bundle=RecipeBundle.find_by(id:n[:recipe_bundle_id])
      if(n[:quantity] < 1)
        raise Exceptions::OrderError.new("Invalid quantity value")
      else
        if(bundle.stock < n[:quantity])
          raise Exceptions::RecipeBundleError.new("Insufficient stock for #{bundle.title}")
        end
        if(bundle.price != n[:price])
          raise Exceptions::RecipeBundleError.new("Price change for #{bundle.title}")
        end
        n[:total_price]=n[:price]*n[:quantity]
        order_total+=n[:total_price]
      end
    end
    params[:order_total]=order_total
    params[:total]=params[:order_total]+params[:shipping_fee]
    params
  end

  def create_payment_link(order)
    url = URI(ENV['ORDER_BASE_URL'])
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request.basic_auth(ENV['DURIAN_PAY_API_KEY'], '')
    request.body = {
      "amount" => "#{order.total}",
      "currency" => "IDR",
      "order_ref_id" => "#{order.id}",
      "is_payment_link" => true,
      "customer" => { 
        "given_name" => "#{order.recipient_name}",
        "email" => "#{@current_user.email}",
        "mobile" => "#{order.recipient_contact}",
      },
    }.to_json
    response = http.request(request)
    if(response.code.to_s != "201")
      raise Exceptions::PaymentError.new("Cant create payment link")
      cancel_order(order)
    end
    result=JSON.parse(response.body)["data"]
    order.order_payment_id=result["id"]
    order.order_payment_link=ENV['PAYMENT_BASE_URL']+result["payment_link_url"]
    if order.save
      order.order_payment_link
    else
      raise Exceptions::PaymentError.new("Cant create payment link")
      cancel_order(order)
    end
    
  end

  def cancel_order(order)
    if(order.status == "unpaid")
      order.status = "cancel"
      order.cancel_time = Time.now
      order.order_details.each do |o|
        bundle=RecipeBundle.find_by(id:o.recipe_bundle_id)
        bundle.stock+=o.quantity
        bundle.save
      end
      order.save
    else
      raise Exceptions::OrderError.new("Cannot cancel, order is already #{order.status}")
    end
  end
  
end

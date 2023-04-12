class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, except: %i[change_status_to_sent]
  RADIUS_COVERED=20
  def shipping_fee
    distance=helpers.distance([-6.947089, 107.577242],params[:latlong])
    if(distance < RADIUS_COVERED)
      min_fare=8000
      additional_fare=(distance-1) * 2500
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "distance": "#{distance} km",
          "shipping_fee": min_fare+additional_fare.round
        }
      }, status: :ok
    
    else
      render json: {
        "status": 422,
        "message": "Location too far",
        "data": {
          "distance": "#{distance} km",
        }
      }, status: :unprocessable_entity 
    end
  end

  def create
    order=Order.new(helpers.create_params(order_params))
    if order.save
      params[:order_details_attributes].each do |n|
        bundle=RecipeBundle.find_by(id:n[:recipe_bundle_id])
        bundle.stock=bundle.stock-n[:quantity]
        bundle.save
      end
      payment_link=helpers.create_payment_link(order)
      render json: {
        "status": 200,
        "message": "Success",
        "data": {
          "order_id": order.id,
          "payment_link": payment_link
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": order.errors
      },status: :unprocessable_entity
    end
    rescue Exceptions::RecipeBundleError,Exceptions::OrderError,Exceptions::PaymentError => e
      render json:{ 
        "status": 422,
        "message":e.to_s
      },status: :unprocessable_entity
  end

  def cancel
    order=Order.find_by(id:params[:id])
    if order
      helpers.cancel_order(order)
      render json: {
        "status": 200,
        "message": "Success",
      }, status: :ok 
    else
      render json: {
        "status": 404,
        "message": "Order not found",
      }, status: :not_found 
    end
    rescue Exceptions::OrderError => e
      render json:{ 
        "status": 422,
        "message":e.to_s
      },status: :unprocessable_entity
  end

  def show_all
    order=Order.newest.where(user_id:@current_user.id)
    render json: {
      "status": 200,
      "message": "Success",
      "data":{
        "orders": order.as_json(Order.order_attr)
      }
    }, status: :ok 
  end
  

  def change_status_to_sent
    order=Order.find_by(id:params[:id])
    helpers.sent_order(order)
    render json: {
      "status": 200,
      "message": "Success",
    }, status: :ok 
    rescue Exceptions::OrderError => e
      render json:{ 
        "status": 422,
        "message":e.to_s
      },status: :unprocessable_entity
  end

  def change_status_to_finished
    order=Order.find_by(id:params[:id])
    helpers.finished_order(order)
    render json: {
      "status": 200,
      "message": "Success",
      "data":{
        "orders": order.as_json(Order.order_attr)
      }
    }, status: :ok 
    rescue Exceptions::OrderError => e
      render json:{ 
        "status": 422,
        "message":e.to_s
      },status: :unprocessable_entity
  end
  
  private
  def order_params
    params.require(:order).permit(
      :shipping_address,
      :shipping_address_notes,
      :recipient_name,
      :recipient_contact,
      :shipping_fee,
      order_details_attributes:[
        :recipe_bundle_id,
        :quantity,
        :price,
      ],
    ).with_defaults(
      user_id: @current_user.id,
    )
  end
end

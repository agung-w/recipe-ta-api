class OrdersController < ApplicationController
  def shipping_fee
    distance=helpers.distance([-6.947089, 107.577242],params[:latlong])
    if(distance < 20)
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
      }, status: :unprocessable_entity 
    end
  end
end

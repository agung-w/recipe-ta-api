class MetricsController < ApplicationController
  def list
    @metrics = Metric.all()
    if @metrics
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "metrics": @metrics
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": "Cant process this now"
      },status: :unprocessable_entity 
    end
  end
end

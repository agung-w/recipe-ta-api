class IngredientsController < ApplicationController
  def find
    @ingredient=Ingredient.where(name:params[:name]).first_or_create
    if @ingredient.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "ingredient": @ingredient.as_json(Ingredient.ingredient_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": @ingredient.errors
      },status: :unprocessable_entity
    end
  end
end

class IngredientsController < ApplicationController
  def find
    ingredient=Ingredient.where(name:params[:name].downcase.tr('^A-Za-z0-9-.', ' ').squish!).first_or_create
    if ingredient.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "ingredient": ingredient.as_json(Ingredient.ingredient_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": ingredient.errors
      },status: :unprocessable_entity
    end
  end

  def get_random_ingredient
    ingredient=Ingredient.verified.order("RANDOM()").first
    render json: {
      "status": 200,
      "message": "Sucess",
      "data": {
        "ingredient": ingredient.as_json(Ingredient.ingredient_attr)
      }
    }, status: :ok 
  end
end

class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, only: %i[create]
  def create
    @recipe=Recipe.new(recipe_params)
    if @recipe.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipe": @recipe.as_json
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": @recipe.errors
      },status: :unprocessable_entity
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(
      :title, 
      :description,
      :poster_pic_url,
      :prep_time,
      :serving,
      recipe_ingredients_attributes:[
        :ingredient_id,
        :quantity,
        :metric_id
      ],
      cooking_steps_attributes:[
        :step,
        :description,
        :pic_url
      ],
      recipe_tags_attributes:[
        :tag_id
      ],
    ).with_defaults(user_id: @current_user.id)
  end
end
class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, only: %i[create show]
  def create
    recipe=Recipe.new(recipe_params)
    if recipe.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipe": recipe.as_json(Recipe.recipe_detail_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": recipe.errors
      },status: :unprocessable_entity
    end
  end

  def show
    recipe=Recipe.find_by(id:params[:id])
    if recipe
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipe": recipe.as_json(Recipe.recipe_detail_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 404,
        "message": "Recipe not found"
      },status: :not_found
    end
  end

  def search_by_title
    recipe=Recipe.where("lower(title) LIKE '%#{params[:query].downcase}%'")
    if recipe
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipes": recipe.as_json(Recipe.recipe_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 404,
        "message": "Recipe not found"
      },status: :not_found
    end
  end

  def search_by_ingredient
    recipe=Recipe.joins(:recipe_ingredients).joins(:ingredients).where("lower(ingredients.name) SIMILAR TO '%#{params[:query].split(',')}%' ").distinct
    if recipe
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipes": recipe.as_json(Recipe.recipe_detail_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 404,
        "message": recipe.errors
      },status: :not_found
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

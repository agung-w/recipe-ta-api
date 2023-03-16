class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, only: %i[create show]
  before_action :authorize_request_or_not?, only: %i[search_by_title search_by_ingredient]
  before_action :query_param, only: %i[search_by_title search_by_ingredient]
  def create
    recipe=Recipe.new(recipe_params)
    if recipe.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipe": recipe.as_json(Recipe.recipe_detail_attr,@current_user)
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
          "recipe": recipe.as_json(Recipe.recipe_detail_attr,@current_user)
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
    recipes=Recipe.where("lower(title) LIKE '%#{query_param.downcase}%'")
    if recipes
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipes": recipes.map { |r| r.as_json(Recipe.recipe_attr,@current_user) }
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
    recipes=Recipe.joins(:recipe_ingredients).joins(:ingredients).where("lower(ingredients.name) SIMILAR TO '%#{query_param.split(',')}%' ").distinct
    if recipes
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipes": recipes.map { |r| r.as_json(Recipe.recipe_attr,@current_user) }
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

  def query_param
    query=params[:query].squish
    if query.length < 1
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipes": []
        }
      }, status: :ok 
    end
    query
  end
end

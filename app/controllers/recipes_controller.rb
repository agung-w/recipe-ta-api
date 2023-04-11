class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, only: %i[create show get_created_recipe]
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
      if(recipe.is_published==true || recipe.user_id==@current_user.id)
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
          "message": "Recipe not published yet"
        },status: :unprocessable_entity
      end
    else
      render json:{
        "status": 404,
        "message": "Recipe not found"
      },status: :not_found
    end
  end

  def search_by_title
    recipes=Recipe.published.where("lower(title) LIKE '%#{query_param.downcase}%'")
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
    recipes=Recipe.published.joins(:recipe_ingredients).joins(:ingredients).where("lower(ingredients.name) SIMILAR TO '%#{query_param.split(',')}%' ").distinct
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
  
  def change_pending_recipe_publish_status
    recipe=Recipe.pending.find_by(id:params[:id])
    if recipe
      status=params[:status].to_s.downcase
      if(status=="rejected"||status=="false"||status=="reject")
        recipe.is_published=false
      elsif(status=="approved"||status=="true"||status=="approve")
        recipe.is_published=true
      end
      if recipe.save! && recipe.is_published!=nil
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
          "message": "Invalid status param"
        },status: :unprocessable_entity
      end
    else
      render json:{
        "status": 404,
        "message": "Pending recipe not found"
      },status: :not_found
    end
  end

  def get_pending_recipes
    recipes=Recipe.pending
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

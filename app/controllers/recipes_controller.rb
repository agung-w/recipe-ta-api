class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, only: %i[create show delete update]
  before_action :query_param, only: %i[search_by_title search_by_ingredient]
  before_action :authorize_request_or_not?, only: %i[search_by_title search_by_ingredient get_random_list]
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
    recipes=helpers.search_by_ingredient(query_param)
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

  def get_random_list
    recipes=Recipe.published.order("RANDOM()").limit(100)
    render json: {
      "status": 200,
      "message": "Sucess",
      "data": {
        "recipes": recipes.map { |r| r.as_json(Recipe.recipe_attr,@current_user) }
      }
    }, status: :ok 
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

  def delete
    if helpers.delete(params[:id], @current_user)
      render json: {
        "status": 200,
        "message": "Sucess"
      }, status: :ok 
    end
    rescue Exceptions::RecipeError => e
      render json:{ 
        "status": 422,
        "message":e.to_s
      },status: :unprocessable_entity
    rescue Exceptions::NotFoundError => e
      render json:{ 
        "status": 404,
        "message":e.to_s
      },status: :unprocessable_entity
  end

  def update
    if recipe=helpers.update(params[:id],recipe_params,@current_user)
      render json: {
        "status": 200,
        "message": "Success",
        "data": {
          "recipe": recipe.as_json(Recipe.recipe_detail_attr,@current_user)
        }
      }, status: :ok 
    end
    rescue Exceptions::RecipeError => e
      render json:{ 
        "status": 422,
        "message":e.to_s
      },status: :unprocessable_entity
    rescue Exceptions::NotFoundError => e
      render json:{ 
        "status": 404,
        "message":e.to_s
      },status: :unprocessable_entity
  end

  private
  def recipe_params
    params.require(:recipe).permit(
      :id,
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

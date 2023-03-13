class SaveRecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request

  def save
    recipe_save=RecipeSavedByUser.new(user_id:@current_user.id,recipe_id:params[:id])
    if recipe_save.save
      recipe=Recipe.find(params[:id])
      recipe.update(favorite_count:recipe.favorite_count+1)
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "saved_recipe_id": recipe_save.recipe_id,
          "recipe_total_saved": recipe.favorite_count
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": recipe_save.errors
      },status: :unprocessable_entity
    end
  end

  def remove
    remove_saved_recipe=RecipeSavedByUser.find_by(recipe_id:params[:id],user_id:@current_user.id)&.destroy
    if remove_saved_recipe
      recipe=Recipe.find(params[:id])
      recipe.update(favorite_count:recipe.favorite_count-1)
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "removed_saved_recipe_id": remove_saved_recipe.recipe_id,
          "recipe_total_saved": recipe.favorite_count
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": "Cant prosses this now"
      },status: :unprocessable_entity
    end
  end

end

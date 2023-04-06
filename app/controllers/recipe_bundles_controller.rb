class RecipeBundlesController < ApplicationController
  def show_all
    comment=RecipeBundle.where(recipe_id:params[:id])
    render json: {
      "status": 200,
      "message": "Sucess",
      "data": {
        "recipe_bundles": comment.as_json()
      }
    }, status: :ok 
  end
end

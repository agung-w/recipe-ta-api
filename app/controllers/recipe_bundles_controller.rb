class RecipeBundlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show_all
    bundles=RecipeBundle.where(recipe_id:params[:id])
    render json: {
      "status": 200,
      "message": "Sucess",
      "data": {
        "recipe_bundles": bundles.as_json()
      }
    }, status: :ok 
  end

  def create
    bundle=RecipeBundle.new(bundle_params)
    if bundle.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipe_bundle": bundle.as_json
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": bundle.errors
      },status: :unprocessable_entity
    end
  end

  private
  def bundle_params
    params.require(:recipe_bundle).permit(
      :recipe_id,
      :title, 
      :description,
      :pic_url,
      :stock,
      :price,
    )
  end
end

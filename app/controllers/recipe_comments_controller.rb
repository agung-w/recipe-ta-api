class RecipeCommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request

  def show
    comment=RecipeComment.where(recipe_id:params[:id]).first
    render json: {
      "status": 200,
      "message": "Sucess",
      "data": {
        "recipe_comment": comment.as_json()
      }
    }, status: :ok 
  end

  def show_all
    comments=RecipeComment.where(recipe_id:params[:id])
    render json: {
      "status": 200,
      "message": "Sucess",
      "data": {
        "recipe_comments": comments.as_json()
      }
    }, status: :ok 
  end

  def create
    comment=RecipeComment.new(comment_params)
    if comment.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipe_comment": comment.as_json()
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": comment.errors
      },status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:recipe_id, :content).with_defaults(user_id: @current_user.id,timestamp:Time.now)
  end

end

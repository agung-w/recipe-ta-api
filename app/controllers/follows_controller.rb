class FollowsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request, only: %i[ follow unfollow ]

  def follow
    @user_to_follow=User.find_by(username: follow_params[:username])
    if @user_to_follow
      @follow=Follow.new(user:@current_user,followed:@user_to_follow)
      if @follow.save   
        @updated_user=@current_user.update(following_count: @current_user.followers_count+1)
        @user_to_follow.update(followers_count:@user_to_follow.followers_count+1)
        render json: {
          "status": 200,
          "message": "Sucess",
          "data": {
            "following_count": @current_user.following_count
          }
        }, status: :ok 
      else
        render json:{
          "status": 422,
          "message": @follow.errors
        },status: :unprocessable_entity
      end
    else
      render json:{
        "status": 404,
        "message": "User not found"
      },status: :not_found
    end
  end

  def unfollow
    @user_to_unfollow=User.find_by(username: follow_params[:username])
    if @user_to_unfollow
      @unfollow=Follow.find_by(user:@current_user,followed:@user_to_unfollow)&.destroy
      if @unfollow
        @current_user.update(following_count:@current_user.following_count-1)
        @user_to_unfollow.update(followers_count:@user_to_unfollow.followers_count-1)
        render json: {
          "status": 200,
          "message": "Sucess",
          "data": {
            "following_count": @current_user.following_count
          }
        }, status: :ok 
      else
        render json:{
          "status": 422,
          "message": "Not followed yet"
        },status: :unprocessable_entity
      end
    else
      render json:{
        "status": 404,
        "message": "User is not registered"
      },status: :not_found
    end
  end

  private
    def follow_params
      params.require(:follow).permit(:username)
    end
end

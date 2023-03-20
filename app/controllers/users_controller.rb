class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, only: %i[my_profile]
  before_action :authorize_request_or_not?, only: %i[get_created_recipe get_saved_recipe]


  def email_login
    user = User.find_by(email:email_login_params[:email])
    if user&.authenticate(email_login_params[:password]) 
      token = AuthTokenService.encode(payload(user))
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "token": token
        }
      }, status: :ok 
    else
      render json:{
        "status": 401,
        "message": "Invalid credentials"
      },status: :unauthorized 
    end
  end

  def get_created_recipe
    if(params[:username])
      recipes=Recipe.joins(:user).where(user: { username: params[:username] })
    else
      if(@current_user)
        recipes=Recipe.where(user:@current_user)
      else
        render json:{ 
          "status": 401,
          "message":"Invalid token provided"
        },status: :unauthorized
      end
    end
    if recipes
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipes": recipes.map { |r| r.as_json(Recipe.recipe_attr,@current_user) }
        }
      }, status: :ok 
    end
    
  end

  def get_saved_recipe
    if(params[:username])
      recipes=Recipe.joins(:recipe_saved_by_user).joins(:user).where(user: { username: params[:username] })
    else
      if(@current_user)
        recipes=Recipe.joins(:recipe_saved_by_user).where("recipe_saved_by_users.user_id = #{@current_user.id}")
      else
        render json:{ 
          "status": 401,
          "message":"Invalid token provided"
        },status: :unauthorized
      end
    end
    if recipes
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "recipes": recipes.map { |r| r.as_json(Recipe.recipe_attr,@current_user) }
        }
      }, status: :ok 
    end
  end

  def email_registration
    username=email_registration_params['username'] ? email_registration_params['username'] : User.generate_default_username
    user = User.new(
      name:email_registration_params['name'],
      username:username,
      email:email_registration_params['email'],
      password:email_registration_params['password'],
      profile_pic_url:email_registration_params['profile_pic_url'],
      followers_count:0,
      following_count:0
    )
    if user.save
      token = AuthTokenService.encode(payload(user))
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "token": token
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": user.errors
      },status: :unprocessable_entity
    end
  end

  def profile
    user=User.find_by(username:params[:username])
    if user
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "user": user.as_json(User.profile_detail_attr)
        }
      }, status: :ok
    else
      render json:{
        "status": 404,
        "message": "User not found"
      },status: :not_found
    end
  end

  def my_profile
    if @current_user
      render json:{
        "status": 200,
        "message": "Sucess",
        "data": {
          "user": @current_user.as_json(User.profile_detail_attr)
        }
      },status: :ok
    else
      render json:{
        "status": 404,
        "message": "User not found"
      },status: :not_found
    end
  end


  private
    def email_registration_params
      params.require(:user).permit(:name, :email, :password, :username,:profile_pic_url)
    end

    def email_login_params
      params.require(:user).permit(:email,:password)
    end
end

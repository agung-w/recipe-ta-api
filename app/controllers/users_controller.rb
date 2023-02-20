class UsersController < ApplicationController
  before_action :authorize_request, only: %i[my_profile]

  def email_login
    @user = User.find_by(email_login_params)
    if @user
      token = AuthTokenService.encode(payload(@user))
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

  def email_registration
    @user = User.new(email_registration_params)
    if @user.save
      token = AuthTokenService.encode(payload(@user))
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
        "message": @user.errors
      },status: :unprocessable_entity
    end
  end

  def my_profile
    render json:@user
  end



  private

    # Only allow a list of trusted parameters through.
    def email_registration_params
      params.require(:user).permit(:name, :email,:username, :password)
    end

    def email_login_params
      params.require(:user).permit(:email,:password)
    end
end

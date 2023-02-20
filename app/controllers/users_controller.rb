class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]



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




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_registration_params
      params.require(:user).permit(:name, :email,:username, :password)
    end

    def email_login_params
      params.require(:user).permit(:email,:password)
    end
end

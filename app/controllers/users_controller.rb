class UsersController < ApplicationController
  def email_login
    @user = User.find_by(email:email_login_params[:email])
    if @user&.authenticate(email_login_params[:password]) 
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
    @user = User.new(
      name:email_registration_params['name'],
      username:email_registration_params['username'],
      email:email_registration_params['email'],
      password:email_registration_params['password'],
    )
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

  def profile
    @user=User.find_by(username:params[:username])
    if @user
      render json:@user.as_json
    else
      render json:{
        "status": 404,
        "message": "User not found"
      },status: :not_found
    end
  end



  private
    # Only allow a list of trusted parameters through.
    def email_registration_params
      params.require(:user).permit(:name, :email, :password, :username)
    end

    def email_login_params
      params.require(:user).permit(:email,:password)
    end
end

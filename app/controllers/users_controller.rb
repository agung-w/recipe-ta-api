class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]



  def email_registration
    @user = User.new(email_registration_params)
    if @user.save
       render :show, status: :ok 
    else
       render json: @user.errors, status: :unprocessable_entity 
    end
  end

  def email_login
    @user = User.new(email_registration_params)
    if @user.save
       render :show, status: :ok 
    else
       render json: @user.errors, status: :unprocessable_entity 
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_registration_params
      params.require(:user).permit(:name, :username, :email, :password)
    end

    def email_login_params
      params.require(:user).permit(:email,:password)
    end
end

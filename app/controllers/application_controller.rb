class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token
  def authorize_request
    token,_options=token_and_options(request)
    decoded=AuthTokenService.decode(token)
    @user=User.find_by!(email:decoded['email'])

    rescue ActiveRecord::RecordNotFound,JWT::DecodeError => e
      render json:{ 
        "status": 401,
        "message":e.to_s
      },status: :unauthorized
  end

  def payload(user)
    {
        'email':user.email,
        'name':user.name,
        'iat':Time.now.to_i
    }
  end
end

class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token
  def authorize_request
    token,_options=token_and_options(request)
    decoded=AuthTokenService.decode(token)
    @current_user=User.find_by!(username:decoded['username'])

    rescue ActiveRecord::RecordNotFound,JWT::DecodeError => e
      render json:{ 
        "status": 401,
        "message":e.to_s
      },status: :unauthorized
  end

  def authorize_request_or_not?
    token,_options=token_and_options(request)
    decoded=AuthTokenService.decode(token)
    @current_user=User.find_by!(username:decoded['username'])

    rescue ActiveRecord::RecordNotFound,JWT::DecodeError => e
  end

  def payload(user)
    {
      'email':user.email,
      'name':user.name,
      'username':user.username,
      'iat':Time.now.to_i
    }
  end
end

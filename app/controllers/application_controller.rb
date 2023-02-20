class ApplicationController < ActionController::Base
  def payload(user)
    {
        'email':user.email,
        'name':user.name,
        'iat':Time.now.to_i
    }
  end
end

Rails.application.routes.draw do
  constraints subdomain: 'api' do
    post '/register/email', to: 'users#email_registration'
    post '/login/email', to: 'users#email_login'
    get '/profile/:username', to: 'users#profile', :as => 'profile'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  # constraints subdomain: 'api' do
  #   post '/register/email', to: 'users#email_registration'
  #   post '/login/email', to: 'users#email_login'
  #   get '/profile/:username', to: 'users#profile', :as => 'profile'
  # end
  post '/register/email', to: 'users#email_registration'
  post '/login/email', to: 'users#email_login'
  get '/profile/:username', to: 'users#profile', :as => 'profile'
  get '/my-profile', to: 'users#my_profile'

  post '/follow', to: 'follows#follow'
  delete '/unfollow', to: 'follows#unfollow'

  post '/recipe/create', to: 'recipes#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

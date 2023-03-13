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
  get '/recipe/:id', to: 'recipes#show', :as => 'recipe'
  get '/search/recipe/by-title/:query', to: 'recipes#search_by_title', :as => 'search-recipe-by-title'
  get '/search/recipe/by-ingredient/:query', to: 'recipes#search_by_ingredient', :as => 'search-recipe-by-ingredient'

  get '/recipe-comments/:id', to: 'recipe_comments#show', :as => 'recipe-comments'
  post '/recipe-comment', to: 'recipe_comments#create'


  get '/ingredient/find/:name', to: 'ingredients#find', :as => 'ingredient-find'


  get '/tag/list', to: 'tags#list'


  get '/metric/list', to: 'metrics#list'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

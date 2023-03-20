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
  get '/created-recipe-by', to: 'users#get_created_recipe', :as => 'created-recipe-by'
  get '/saved-recipe-by', to: 'users#get_saved_recipe', :as => 'saved-recipe-by'

  post '/follow', to: 'follows#follow'
  delete '/unfollow', to: 'follows#unfollow'

  post '/recipe/create', to: 'recipes#create'
  get '/recipe/:id', to: 'recipes#show', :as => 'recipe'
  get '/search/recipe/by-title', to: 'recipes#search_by_title', :as => 'search-recipe-by-title'
  get '/search/recipe/by-ingredient', to: 'recipes#search_by_ingredient', :as => 'search-recipe-by-ingredient'
  get '/created-recipe', to: 'recipes#get_created_recipe'
  get '/saved-recipe', to: 'recipes#get_saved_recipe'

  get '/recipe-comments/:id', to: 'recipe_comments#show', :as => 'recipe-comments'
  post '/recipe-comment', to: 'recipe_comments#create'

  put '/save-recipe/:id', to: 'save_recipes#save', :as => 'save-recipe'
  delete '/save-recipe/:id', to: 'save_recipes#remove'

  get '/ingredient/find', to: 'ingredients#find', :as => 'ingredient-find'


  get '/tag/list', to: 'tags#list'


  get '/metric/list', to: 'metrics#list'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

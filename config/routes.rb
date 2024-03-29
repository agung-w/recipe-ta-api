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
  get '/created-recipe-by', to: 'users#get_created_recipes', :as => 'created-recipe-by'
  get '/saved-recipe-by', to: 'users#get_saved_recipes', :as => 'saved-recipe-by'
  get '/draft-recipes', to: 'users#get_draft_recipes'
  get '/rejected-recipes', to: 'users#get_rejected_recipes'
  get '/pending-recipes', to: 'users#get_pending_recipes'

  post '/follow', to: 'follows#follow'
  delete '/unfollow', to: 'follows#unfollow'

  post '/recipe/create', to: 'recipes#create'
  delete '/recipe/delete', to: 'recipes#delete'
  put '/recipe/update', to: 'recipes#update'
  get '/recipe/:id', to: 'recipes#show', :as => 'recipe'
  get '/search/recipe/by-title', to: 'recipes#search_by_title', :as => 'search-recipe-by-title'
  get '/search/recipe/by-ingredient', to: 'recipes#search_by_ingredient', :as => 'search-recipe-by-ingredient'
  get '/random-recipe-list', to: 'recipes#get_random_list'


  get '/recipe-comments/:id', to: 'recipe_comments#show_all', :as => 'recipe-comments'
  get '/first-recipe-comment/:id', to: 'recipe_comments#show', :as => 'first-recipe-comment'
  post '/recipe-comment', to: 'recipe_comments#create'

  put '/save-recipe/:id', to: 'save_recipes#save', :as => 'save-recipe'
  delete '/save-recipe/:id', to: 'save_recipes#remove'
  
  scope '/ingredient' do
    get '/find', to: 'ingredients#find', :as => 'ingredient-find'
    get '/random', to: 'ingredients#get_random_ingredient'
  end

  get '/tag/list', to: 'tags#list'
  get '/tag/find', to: 'tags#find', :as => 'tag-find'


  get '/metric/list', to: 'metrics#list'

  get '/recipe-bundles/:id', to: 'recipe_bundles#show_all', :as => 'recipe-bundles'
  
  scope '/order' do
    get '/shipping-fee', to:'orders#shipping_fee'
    post '/create', to:'orders#create'
    put '/cancel', to:'orders#cancel', :as => 'order-cancel'
    get '/history', to:'orders#show_all'
    put '/check-payment-status', to:'orders#check_payment_status', :as => 'order-check-payment-status'
  end
  

  scope '/admin' do
    post '/recipe-bundle/create', to: 'recipe_bundles#create'
    put '/recipe/change/publish-status/:id', to: 'recipes#change_pending_recipe_publish_status'
    get '/recipe/pending-list', to: 'recipes#get_pending_recipes'
    put '/order/sent', to: 'orders#change_status_to_sent'
    put '/order/finished', to: 'orders#change_status_to_finished'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

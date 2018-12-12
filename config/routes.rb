Rails.application.routes.draw do
  resources :cart
  devise_for :users
  get 'home/index'
  root to: "home#index"
  get '/contact', to: "home#contact"
  get '/explore', to: "home#explore"
  post '/search_game', to: 'listing#search_game'
  get '/search_cat', to: 'listing#search_cat'
  get '/dashboard', to: "dashboard#index"
  get '/add_copy', to: "dashboard#rent_copy"
  get '/show_orders/:id', to: 'dashboard#toggle_past'
  post '/add_copy', to: "dashboard#save_copy"
  patch '/confirm/:id', to: 'dashboard#confirm_copy'
  put '/return/:id', to: 'dashboard#return_copy'
  put '/available/:id', to: 'dashboard#available_copy'
  get '/admin', to: 'admin#index'
  get '/users', to: 'admin#users'
  get '/users/:id', to: 'admin#show'
  get '/games/:id', to: 'admin#game'
  
  resources :charges
  resources :listing
  resources :new_games
  post "/new_games/new", to: 'new_games#create'
  get '/gameshow', to: 'new_games#show'
  
  get '/cart', to: "cart#index"
  get '/empty', to: 'cart#empty'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :cart
  devise_for :users
  get 'home/index'
  root to: "home#index"
  get '/contact', to: "home#contact"
  get '/explore', to: "home#explore"
  get '/dashboard', to: "dashboard#index"
  get '/add_game', to: "dashboard#add_game"
  post '/add_game', to: "dashboard#save_game"
  resources :charges
  resources :listing
  get '/cart', to: "cart#index"
  get '/show_orders/:id', to: 'user#toggle_past'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

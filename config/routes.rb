Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root to: "home#index"
  get '/contact', to: "home#contact"
  get '/explore', to: "home#explore"
  get '/listing', to: "home#listing"
  get '/dashboard', to: "user#index"
  get '/addgame', to: "user#add_game"
  resources :charges
  get '/new', to:"add_games#new"
  post '/new', to:"add_games#create"
  get '/gameshow', to: 'add_games#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

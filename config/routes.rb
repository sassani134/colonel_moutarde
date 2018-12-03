Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users
=======
  get 'home/index'
  get '/index', to: 'home#index'
>>>>>>> 3ae1af20ff28ea30025644113e4390f75c042e86
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

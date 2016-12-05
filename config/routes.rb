Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:new, :create]


  get "welcome/index"

  get "welcome/about"

  root 'welcome#index'

end

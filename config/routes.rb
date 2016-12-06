Rails.application.routes.draw do

  devise_for :users
  resources :wikis


  resources :users, only: [:new, :create]

  # post 'users'

  get "welcome/index"

  get "welcome/about"

  root 'welcome#index'

end

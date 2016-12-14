Rails.application.routes.draw do

  devise_for :users
  resources :wikis

  # resources :charge, only: [:new, :create]

  get "welcome/index"
  root 'welcome#index'

end

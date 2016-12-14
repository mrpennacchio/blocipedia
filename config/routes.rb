Rails.application.routes.draw do


  devise_for :users
  resources :wikis

  # allows a users/show view for a prof. page
  devise_scope :user do
    get "users/show"
    get "users/down_grade"
  end

  resources :charges, only: [:new, :create]
  post "charges/new"
  get "users/show"
  get "welcome/index"
  root 'welcome#index'

end

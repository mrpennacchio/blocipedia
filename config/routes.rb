Rails.application.routes.draw do


  devise_for :users

  resources :wikis do
    member do
        put :add_collaborator
        put :remove_collaborator
      end
   end
  # allows a users/show view for a prof. page
  devise_scope :user do
    get "users/show"
    get "users/down_grade"
  end
  # resources :users, only: [:show] do
  #   member do
  #     get :down_grade
  #   end
  # end

  resources :charges, only: [:new, :create]
  get "welcome/index"
  root 'welcome#index'

end

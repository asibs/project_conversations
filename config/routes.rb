Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :projects, except: :destroy do
    resources :comments, only: :create
  end

  # Defines the root path route ("/")
  root "projects#index"
end

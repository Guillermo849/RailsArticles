Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :articles
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'

  get 'create_user' => 'users#new', as: :create_new_user
  post 'create_user' => 'users#create', as: :create_user
end

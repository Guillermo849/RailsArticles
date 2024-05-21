Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users do
    resources :articles
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
end

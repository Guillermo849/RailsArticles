Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root to: redirect('users#index')

  get 'user', to: 'users#index'
  post 'user/create', to: 'users#create'
  get 'user/new', to: 'users#new', as: 'new_users'
end

Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show]
  end

  resources :posts, only: [:index, :new, :create, :show] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:new, :create]
  end
  # Defines the root path route ("/")
  root 'users#index'
end

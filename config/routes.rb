Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy'
  end

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

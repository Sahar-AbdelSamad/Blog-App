Rails.application.routes.draw do
  devise_for :users, path_names: { 
    sign_in: 'login', 
    sign_out: 'logout', 
    password: 'secret', 
    confirmation: 'verification', 
    unlock: 'unblock', 
    registration: 'register', 
    sign_up: 'sign_up'
  }
  # devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords'} 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get '/sign_out', to: 'users/sessions#destroy'
    get '/sign_up', to: 'users/registrations#new'
    get '/login', to: 'users/sessions#new'
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

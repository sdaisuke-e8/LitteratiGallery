Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#about'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  resources :users
  resources :posts do
    resources :comments, only: [:new, :create]
    resources :favorites, only: [:create, :destroy]
  end
end

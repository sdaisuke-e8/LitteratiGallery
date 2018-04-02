Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :omniauth_callbacks => 'omniauth_callbacks'
  }
  resources :users, :only => [:show]

  get '/comments', to: 'comments#new'
  post '/comments', to: 'comments#create'

  root 'pages#home'
  get '/about', to: 'pages#about'

  resources :posts do
    resources :comments, only: [:new, :create]
    resources :favorites, only: [:create, :destroy]
  end
end

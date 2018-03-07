Rails.application.routes.draw do
  get '/signup' => 'users#new'

  get '/about' => 'pages#about'
  root 'pages#home'

  resources 'users'
end

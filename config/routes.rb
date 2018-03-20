Rails.application.routes.draw do
  get '/comments', to: 'comments#new'
  post '/comments', to: 'comments#create'

  root 'pages#home'
  get '/about', to: 'pages#about'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  resources :users, :only => [:new, :create, :show]
  resources 'posts'

  post '/favorites/:post_id/create', to: 'favorites#create'
  post '/favorites/:post_id/destroy', to: 'favorites#destroy'
end

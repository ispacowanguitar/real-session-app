Rails.application.routes.draw do
  devise_for :users
  
  get '/' => 'songs#index'
  get '/songs' => 'songs#index'
  get '/songs/search' => 'songs#search'
  post '/songs' => 'songs#user_songs_add'
  get '/songs/new' => 'songs#new'
  post '/songs' => 'songs#create'
  get '/songs/:id' => 'songs#show'
  delete '/songs/:id' => 'songs#destroy'

  get '/sessions/search_users' => 'sessions#search_users'
  post '/sessions/create_session' => 'sessions#create_session'
end

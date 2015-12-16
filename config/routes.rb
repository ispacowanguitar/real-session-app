Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations" }
  
  get '/' => 'songs#index'
  get '/songs' => 'songs#index'
  get '/songs/search' => 'songs#search'
  post '/songs' => 'songs#user_songs_add'
  get '/songs/new' => 'songs#new'
  post '/songs' => 'songs#create'
  get '/songs/:id' => 'songs#show'
  delete '/songs/:id' => 'songs#destroy'

  get '/sessions/new' => 'sessions#new'
  post '/sessions/create' => 'sessions#create'
  get '/sessions/:id/search_users' => 'sessions#search_users'
  post '/sessions/:id/add' => 'sessions#add_members_to_session'
  get '/sessions/:id/play' => 'sessions#play'
end

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations" }
  
  get '/' => 'songs#index'
  get '/songs' => 'songs#index'
  get '/songs/sort/:style' => 'songs#index'
  get '/songs/search' => 'songs#search'
  post '/songs' => 'songs#user_songs_add'
  get '/songs/new' => 'songs#new'
  post '/songs' => 'songs#create'
  get '/songs/users_search' => 'songs#users_search'
  get '/songs/stats' => 'songs#stats'
  delete '/songs/:id' => 'songs#destroy'

  get '/sessions' => 'sessions#index'
  get '/sessions/new' => 'sessions#new'
  post '/sessions/create' => 'sessions#create'
  post '/sessions/:id/invite' => 'sessions#invite'
  get '/sessions/:id/play' => 'sessions#play'
  get '/sessions/:id/play/:style' => 'sessions#play'

  get '/invitations' => 'invitations#index'
  get '/invitations/:id/search_users' => 'invitations#search_users'
  post '/invitations/:id' => 'invitations#create'
  post '/invitations/:id/send' => 'invitations#send_invitations'
  post '/invitations/:invitation_id/:response/response' => 'invitations#reply'

  namespace :api do
    get '/songs' => 'songs#get_songs'
    get '/user_id' => 'songs#find_user'
    get '/session_users/:id' => 'songs#get_users'
    get '/search_songs' => 'songs#search_songs'
    get '/remove_song/:id' => 'songs#remove' 
  end
end

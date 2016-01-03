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

  get '/sessions' => 'sessions#index'
  get '/sessions/new' => 'sessions#new'
  post '/sessions/create' => 'sessions#create'
  post '/sessions/:id/invite' => 'sessions#invite'
  # post '/sessions/:id/send_invitations' => 'sessions#send_invitations'
  get '/sessions/:id/play' => 'sessions#play'
  # get '/sessions/invitations' => 'sessions#invitations'

  get '/invitations' => 'invitations#index'
  get '/invitations/:id/search_users' => 'invitations#search_users'
  post '/invitations/:id' => 'invitations#create'
  post '/invitations/:id/send' => 'invitations#send_invitations'
  post '/invitations/:invitation_id/:response/response' => 'invitations#reply'

  namespace :api do
    get '/songs' => 'songs#get_songs'
    get '/songs/:style' => 'songs#get_styles'
  end
end

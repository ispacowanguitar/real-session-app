class Api::SongsController < ApplicationController
  
  def get_songs

    if params[:user_id]
      user_id = params[:user_id]
      user = User.find(user_id)
      songs = Hash.new
      songs["user"] = User.find(params[:user_id])
      songs["song_array"] = user.songs
    else
      songs = Song.all
    end
      
    if params[:style]
      songs = Song.sort_by_style(songs)[params[:style]]
    end

      render :json => songs
  end

  def get_users
    current_session = Session.find(params[:id])
    session_users = current_session.users

    render :json => session_users
  end
  

  
  def find_user
    render :json => current_user
  end


end

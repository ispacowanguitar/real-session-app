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
  
  def search_songs
    if params[:title]
      title = params[:title].split("%20").join(" ")
      songs = Song.where('title LIKE?', "%#{title}%")
      render :json => songs
    end

    if !params[:title] && params[:composer]
      composer = params[:composer].split("%20").join(" ")
      songs = Song.where('composer LIKE?', "%#{composer}%")
      render :json => songs
    end
  end
  
  def find_user
    if params[:user_name]
      if params[:user_name].include?(" ")  
        first_name = params[:user_name].split(" ")[0]
        last_name = params[:user_name].split(" ")[1]
      else
        first_name = first_name = params[:user_name]
        last_name = first_name = params[:user_name]
      end
      puts params[:user_name]
      puts "FIRST NAME = #{first_name}             LAST NAME=#{last_name}"
      user = User.where('first_name LIKE? or last_name LIKE?', "%#{first_name}%", "%#{last_name}%")
      render :json => user
    else
      render :json => current_user
    end
  end

  def remove
    user_song = UserSong.find_by(user_id: current_user.id, song_id: params[:id])
    user_song.destroy
    render :json => current_user
  end

end

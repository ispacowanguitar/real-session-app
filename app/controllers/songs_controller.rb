class SongsController < ApplicationController

  before_action :authenticate_user!

  def index
    @songs = current_user.songs
    @styles = Song.sort_by_style(current_user.songs)
    if params[:style]
      @songs = Song.sort_by_style(current_user.songs)[params[:style]]
    end 
  end

  def new
  end

  def search

    @songs = Song.where('title LIKE?', "%#{params[:search]}%")

    if params[:search] == nil
      @songs = []
    end

  end

  def create
    Song.create(
      title: params[:title],
      style: params[:style],
      composer: params[:composer],
      tempo: params[:tempo]
      )
    redirect_to '/songs'
  end

  def user_songs_add
    array_of_song_ids = params[:songs]
    array_of_song_ids.each do |id|
    unless current_user.songs.find_by(id: id)    
      UserSong.create(
        user_id: current_user.id,
        song_id: id.to_i
        )
    end
    end
    redirect_to '/songs'
  end
end

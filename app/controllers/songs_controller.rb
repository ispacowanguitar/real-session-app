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

  def users_search
  end

  def stats
    songs_ordered_by_count = UserSong.group("song_id").count.sort_by  {|key, value| value}.reverse

    @top_songs = []
    songs_ordered_by_count.each do |song_id, count|
      @top_songs << [Song.find(song_id), count]
    end
    @top_ten = @top_songs.first(10)


    users_ordered_by_count = UserSong.group("user_id").count.sort_by {|key, value| value}.reverse
  
    @top_users = []
    users_ordered_by_count.each do |user_id, count|
      @top_users << [User.find(user_id), count]
    end
    @top_five_users = @top_users.first(5)
  end
end

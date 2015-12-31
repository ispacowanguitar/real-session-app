module SessionsHelper

  def all_common_songs(current_session)
    available_songs = []
    current_user.songs.each do |song|
      add_song = true
      current_session.users.each do |user|
        unless user.songs.exists?(song.id)
          add_song = false
        end
      end
      if add_song
        available_songs << song
      end
    end
    available_songs
  end



end

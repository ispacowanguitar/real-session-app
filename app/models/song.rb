class Song < ActiveRecord::Base
  # session 
  has_many :user_songs
  has_many :users, through: :user_songs

  has_many :user_sessions
  has_many :sessions, through: :user_sessions

  def self.sort_by_style(songs_array)
    return songs_array.group_by {|song| song.style }
  end
end

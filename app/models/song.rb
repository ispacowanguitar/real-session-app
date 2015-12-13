class Song < ActiveRecord::Base
  # session 
  has_many :user_songs
  has_many :users, through: :user_songs

  has_many :user_sessions
  has_many :sessions, through: :user_sessions

end

class Session < ActiveRecord::Base
  has_many :user_sessions
  has_many :users, through: :user_sessions
  
  has_many :song_sessions
  has_many :songs, through: :song_sessions

  has_many :invitations
end

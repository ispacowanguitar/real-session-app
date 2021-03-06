class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :user_songs
  has_many :songs, through: :user_songs

  has_many :user_sessions
  has_many :sessions, through: :user_sessions

  has_many :invitations

  def timeout_in
      1.day
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

class SongSession < ActiveRecord::Base
  belongs_to :song
  belongs_to :session
end

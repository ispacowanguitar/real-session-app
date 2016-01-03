class Status < ActiveRecord::Base
  has_many :invitations
end

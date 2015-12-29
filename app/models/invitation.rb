class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender
  belongs_to :status
  belongs_to :session
end

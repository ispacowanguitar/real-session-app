class ChangeRevieverToUser < ActiveRecord::Migration
  def change
    rename_column :invitations, :reciever_id, :user_id
  end
end

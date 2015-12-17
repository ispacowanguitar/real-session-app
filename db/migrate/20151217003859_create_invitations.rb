class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :session_id
      t.integer :sender_id
      t.integer :reciever_id

      t.timestamps null: false
    end
  end
end

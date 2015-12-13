class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.integer :user_id
      t.integer :session_id
      t.boolean :admin

      t.timestamps null: false
    end
  end
end

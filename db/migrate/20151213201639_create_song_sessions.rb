class CreateSongSessions < ActiveRecord::Migration
  def change
    create_table :song_sessions do |t|
      t.integer :song_id
      t.integer :session_id

      t.timestamps null: false
    end
  end
end

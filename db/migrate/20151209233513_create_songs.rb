class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.text :title
      t.text :style
      t.text :composer
      t.integer :tempo

      t.timestamps null: false
    end
  end
end

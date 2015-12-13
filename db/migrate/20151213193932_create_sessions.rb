class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :location
      t.time :time
      t.string :description

      t.timestamps null: false
    end
  end
end

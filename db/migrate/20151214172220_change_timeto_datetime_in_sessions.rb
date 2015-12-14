class ChangeTimetoDatetimeInSessions < ActiveRecord::Migration
  def change
    change_column :sessions, :time, :datetime
  end
end

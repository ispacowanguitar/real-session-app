class ChangeStatusToStatusid < ActiveRecord::Migration
  def change
    remove_column :invitations, :status, :string
    add_column :invitations, :status_id, :integer
  end
end

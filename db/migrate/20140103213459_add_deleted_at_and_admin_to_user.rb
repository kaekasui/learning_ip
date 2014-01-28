class AddDeletedAtAndAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :timestamp
    add_column :users, :admin, :boolean, default: false
  end
end

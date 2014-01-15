class AddVirtualEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :virtual_email, :string
  end
end

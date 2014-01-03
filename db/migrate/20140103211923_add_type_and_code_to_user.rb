class AddTypeAndCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :code, :string
  end
end

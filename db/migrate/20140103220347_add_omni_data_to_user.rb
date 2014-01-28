class AddOmniDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :name, :string
    add_column :users, :screen_name, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
  end
end

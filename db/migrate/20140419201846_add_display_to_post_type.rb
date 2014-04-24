class AddDisplayToPostType < ActiveRecord::Migration
  def change
    add_column :post_types, :display, :boolean
  end
end

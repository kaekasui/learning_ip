class AddPostTypeIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_type_id, :string
    add_column :posts, :integer, :string
  end
end

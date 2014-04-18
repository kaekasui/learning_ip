class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.timestamp :post_at
      t.string :title
      t.text :content
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

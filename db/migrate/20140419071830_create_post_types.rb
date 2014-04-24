class CreatePostTypes < ActiveRecord::Migration
  def change
    create_table :post_types do |t|
      t.string :name
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

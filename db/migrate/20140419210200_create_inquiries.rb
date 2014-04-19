class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.text :content
      t.integer :user_id
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

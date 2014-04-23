class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.integer :display_cases_count
      t.integer :test_time
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

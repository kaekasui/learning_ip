class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.integer :section_id
      t.integer :category_id
      t.string :age
      t.text :content
      t.text :answer_a
      t.text :answer_b
      t.text :answer_c
      t.text :answer_d
      t.string :answer
      t.text :comment
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

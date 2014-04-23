class AddAllOrCountToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :all_or_count, :integer
  end
end

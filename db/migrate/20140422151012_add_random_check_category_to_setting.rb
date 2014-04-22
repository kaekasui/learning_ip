class AddRandomCheckCategoryToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :random_check_category, :boolean
  end
end

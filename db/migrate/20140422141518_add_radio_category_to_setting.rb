class AddRadioCategoryToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :radio_category, :integer
  end
end

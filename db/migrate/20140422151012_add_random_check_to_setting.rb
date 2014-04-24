class AddRandomCheckToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :random_check, :boolean
  end
end

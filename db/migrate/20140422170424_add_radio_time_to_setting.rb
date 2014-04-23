class AddRadioTimeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :radio_time, :integer
  end
end

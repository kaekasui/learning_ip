class AddNonOrTimeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :non_or_time, :integer
  end
end

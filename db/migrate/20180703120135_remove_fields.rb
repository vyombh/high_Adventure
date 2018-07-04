class RemoveFields < ActiveRecord::Migration
  def change
	remove_column :roomtypes, :wifi
	remove_column :roomtypes, :geyser
	remove_column :roomtypes, :ac
	remove_column :roomtypes, :cooler
	remove_column :roomtypes, :fan
	remove_column :roomtypes, :smoking
	remove_column :roomtypes, :balcony
	remove_column :roomtypes, :bathroom
	remove_column :roomtypes, :pwd
	remove_column :roomtypes, :familyrooms
	remove_column :roomtypes, :kettle
	remove_column :roomtypes, :laundry

  end
end

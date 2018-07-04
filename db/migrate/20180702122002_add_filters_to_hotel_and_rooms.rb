class AddFiltersToHotelAndRooms < ActiveRecord::Migration
  def change
	add_column :hotels, :basic, :text
	add_column :hotels, :media, :text
	add_column :hotels, :food, :text
	add_column :hotels, :disability, :text
	add_column :hotels, :entertainment, :text
	add_column :roomtypes, :basic, :text
	add_column :roomtypes, :restroom, :text
	add_column :roomtypes, :services, :text
	add_column :roomtypes, :view, :text
  end
end

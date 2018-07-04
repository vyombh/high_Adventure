class RemoveExtraFields < ActiveRecord::Migration
  def change
  	remove_column :hotels, :spa
	remove_column :hotels, :pool
	remove_column :hotels, :bar
	remove_column :hotels, :restaurant
	remove_column :hotels, :fan
	remove_column :hotels, :parking
	remove_column :hotels, :gym	
	remove_column :hotels, :lift
	remove_column :hotels, :facilities
  end
  	
end

class RemoveFacilitiesFromRoomtypes < ActiveRecord::Migration
  def change
    remove_column :roomtypes, :facilities
  end
end

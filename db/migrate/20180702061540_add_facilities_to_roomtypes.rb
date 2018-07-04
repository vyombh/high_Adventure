class AddFacilitiesToRoomtypes < ActiveRecord::Migration
  def change
    add_column :roomtypes, :facilities, :text
  end
end

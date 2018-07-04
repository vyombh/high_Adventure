class AddExtrabedToRoomtypes < ActiveRecord::Migration
  def change
    add_column :roomtypes, :extrabed, :integer, default: 0
  end
end

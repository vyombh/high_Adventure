class AddImagesToRoomtypes < ActiveRecord::Migration
  def change
    add_column :roomtypes, :images, :string
  end
end

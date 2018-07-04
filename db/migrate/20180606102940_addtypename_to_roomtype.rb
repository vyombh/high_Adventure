class AddtypenameToRoomtype < ActiveRecord::Migration
  def change
    add_column :roomtypes, :typename, :string
  end
end

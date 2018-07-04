class AddFacilitiesToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :facilities, :text
  end
end

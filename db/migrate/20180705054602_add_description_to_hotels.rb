class AddDescriptionToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :description, :text
    add_column :hotels, :policies, :text
  end
end

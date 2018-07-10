class AddImagesToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :images, :string
  end
end

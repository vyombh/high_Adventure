class AddCityToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :city, :string
    add_column :hotels, :state, :string
    add_column :hotels, :country, :string
    add_column :hotels, :zipcode, :string
    
  end
end

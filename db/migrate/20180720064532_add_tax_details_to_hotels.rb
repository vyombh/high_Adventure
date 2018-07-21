class AddTaxDetailsToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :tax, :boolean
    add_column :hotels, :foodtaxsame, :boolean
  end
end

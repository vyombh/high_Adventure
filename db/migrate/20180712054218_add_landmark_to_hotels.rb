class AddLandmarkToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :landmark, :string
    add_column :hotels, :phnno1, :string
    add_column :hotels, :phnno2, :string
    add_column :hotels, :landline, :string
    add_column :hotels, :email, :string
  end
end

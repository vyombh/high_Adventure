class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :hotelname
      t.string :hoteltype
      t.string :chainname
      t.integer :floor
      t.string :currency
      t.float :rating
      t.integer :year
      t.integer :checkinhrsfrom
      t.integer :checkinminfrom
      t.string :checkinampmfrom
      t.integer :checkinhrsto
      t.integer :checkinminto
      t.string :checkinampmto
      t.integer :checkouthrsfrom
      t.integer :checkoutminfrom
      t.string :checkoutampmfrom
      t.integer :checkouthrsto
      t.integer :checkoutminto
      t.string :checkoutampmto
      t.string :streetname
      t.string :buildingname
      t.boolean :parking,default: false
      t.boolean :gym,default: false
      t.boolean :spa,default: false
      t.boolean :pool,default: false
      t.boolean :bar,default: false
      t.boolean :restaurant,default: false
      t.boolean :lift,default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

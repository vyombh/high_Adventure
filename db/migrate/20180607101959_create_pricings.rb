class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.float :baseprice
      t.float :lunch
      t.float :dinner
      t.float :breakfast
      t.references :roomtype, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

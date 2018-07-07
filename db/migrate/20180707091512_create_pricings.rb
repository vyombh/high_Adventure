class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.text :price
      t.references :hotel, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

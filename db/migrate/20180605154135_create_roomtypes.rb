class CreateRoomtypes < ActiveRecord::Migration
  def change
    create_table :roomtypes do |t|
      t.integer :rooms
      t.string :beds
      t.integer :adults
      t.integer :children, default: 0
      t.boolean :wifi, default: false
      t.boolean :geyser, default: false
      t.boolean :ac, default: false
      t.boolean :cooler, default: false
      t.boolean :fan, default: false
      t.boolean :smoking, default: false
      t.boolean :balcony, default: false
      t.boolean :bathroom, default: false
      t.boolean :kettle, default: false
      t.boolean :laundry, default: false
      t.boolean :tv, default: false
      t.boolean :familyrooms, default: false
      t.boolean :pwd, default: false
      t.references :hotel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

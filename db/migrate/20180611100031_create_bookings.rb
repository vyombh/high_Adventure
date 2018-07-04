class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :checkin
      t.date :checkout
      t.integer :rooms
      t.references :roomtype
      t.references :customer

      t.timestamps null: false
    end
  end
end

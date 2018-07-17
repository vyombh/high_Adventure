class CreateBookinglogs < ActiveRecord::Migration
  def change
    create_table :bookinglogs do |t|
      t.references :hotel, index: true, foreign_key: true
      t.text :booking

      t.timestamps null: false
    end
  end
end

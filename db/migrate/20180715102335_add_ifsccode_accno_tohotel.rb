class AddIfsccodeAccnoTohotel < ActiveRecord::Migration
  def change
  	add_column :hotels, :accholder, :string
    add_column :hotels, :accno, :string
    add_column :hotels, :gstno, :string
    add_column :hotels, :ifsccode, :string
    add_column :hotels, :panno, :string
  end
end

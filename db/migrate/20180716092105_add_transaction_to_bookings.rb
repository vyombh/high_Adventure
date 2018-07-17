class AddTransactionToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :transaction_id, :string
    add_column :bookings, :transaction_status, :string
  end
end

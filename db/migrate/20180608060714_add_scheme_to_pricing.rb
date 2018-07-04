class AddSchemeToPricing < ActiveRecord::Migration
  def change
    add_column :pricings, :scheme, :integer, default: 0
  end
end

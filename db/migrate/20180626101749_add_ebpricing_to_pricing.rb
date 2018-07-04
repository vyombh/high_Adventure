class AddEbpricingToPricing < ActiveRecord::Migration
  def change
    add_column :pricings, :ebpricing, :float,default: 0
  end
end

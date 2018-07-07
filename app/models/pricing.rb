class Pricing < ActiveRecord::Base
  belongs_to :hotel
  serialize :price
  validates_uniqueness_of :hotel

end

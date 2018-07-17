class Bookinglog < ActiveRecord::Base
  belongs_to :hotel
  serialize :booking
  validates_uniqueness_of :hotel

end

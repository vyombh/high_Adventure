class Customer < ActiveRecord::Base
  has_many :bookings, dependent: :destroy

end

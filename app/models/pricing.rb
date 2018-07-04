class Pricing < ActiveRecord::Base
  belongs_to :roomtype
	validates :baseprice,presence: true
    validates :lunch,presence: true
    validates :breakfast,presence: true
    validates :dinner,presence: true
    validates :scheme,presence: true
end
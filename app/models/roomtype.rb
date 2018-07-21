class Roomtype < ActiveRecord::Base
	belongs_to :hotel
	belongs_to :user
	has_many :bookings, dependent: :destroy
	validates :typename,presence: true
	validates :rooms,presence: true
	validates :infants,presence: true
	validates :beds,presence: true
	validates :baseadults,presence: true,inclusion: 0..10
	validates :basechildren,presence: true,inclusion: 0..10
	validates :maximumadults,presence: true ,inclusion: 0..10
	validates :maximumchildren,presence: true ,inclusion: 0..10
	validates :maximumguests,presence: true,inclusion: 0..30
	validates :extrabed,presence: true,numericality: {greater_than_or_equal_to: 0}
	serialize :facilities
	serialize :basic,Hash
    serialize :view,Hash
    serialize :restroom,Hash
    serialize :services,Hash
	mount_uploaders :images, PhotoUploader
    serialize :images, JSON
end

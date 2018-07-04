class Hotel < ActiveRecord::Base
  belongs_to :user
  has_many :roomtypes, dependent: :destroy
    validates :hotelname,presence: true
    validates :hoteltype,presence: true
    validates :floor,presence: true
    validates :currency,presence: true
    validates :rating,presence: true
    validates :year,presence: true
    validates :checkinhrsfrom,presence: true
    validates :checkinminfrom,presence: true
    validates :checkinampmfrom,presence: true
    validates :checkinhrsto,presence: true
    validates :checkinminto,presence: true
    validates :checkinampmto,presence: true
    validates :checkouthrsfrom,presence: true
    validates :checkoutminfrom,presence: true
    validates :checkoutampmfrom,presence: true
    validates :checkouthrsto,presence: true
    validates :checkoutminto,presence: true
    validates :checkoutampmto,presence: true
    validates :streetname,presence: true
    validates :buildingname,presence: true
    validates :zipcode,presence: true
    validates :country,presence: true
    validates :state,presence: true
    validates :city,presence: true
    validates_uniqueness_of :user
    validates_format_of :floor, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :year, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkinhrsfrom, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkinminfrom, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkinhrsto, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkinminto, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkouthrsfrom, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkoutminfrom, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkouthrsto, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :checkoutminto, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    validates_format_of :zipcode, numericality: {only_integer: true}, with: /\A[0-9]*\Z/, message: 'Only numbers allowed'
    serialize :disability,Hash
    serialize :facilities,Hash
    serialize :media,Hash
    serialize :entertainment,Hash
    serialize :food,Hash
    serialize :basic,Hash
    
end

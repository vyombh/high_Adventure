json.extract! hotel, :id, :hotelname, :hoteltype, :chainname, :floor, :currency, :rating, :year, :checkinhrsfrom, :checkinminfrom, :checkinampmfrom, :checkinhrsto, :checkinminto, :checkinampmto, :checkouthrsfrom, :checkoutminfrom, :checkoutampmfrom, :checkouthrsto, :checkoutminto, :checkoutampmto, :streetname, :buildingname, :parking, :gym, :spa, :pool, :bar, :restaurant, :lift, :user_id, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
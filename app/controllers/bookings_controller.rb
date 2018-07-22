require 'json'
class BookingsController < ApplicationController
	def checkRoomEligiblity(room,checkin,checkout,hotel)
	    freq = -1
	    if hotel.bookinglog != nil
	      booking = hotel.bookinglog.booking[room.id]
	      for i in 0...booking.length
	        if booking[i][:start]<=checkin && booking[i][:end] > checkin && booking[i][:end] >= checkout

	          if freq < booking[i][:frequency]
	            freq = booking[i][:frequency]
	          end
	          return freq

	        elsif booking[i][:start]<=checkin && booking[i][:end] > checkin && booking[i][:end] < checkout
	          
	          if freq < booking[i][:frequency]
	            freq = booking[i][:frequency]
	          end
	          checkin = booking[i][:end]

	        end
	        i = i + 1
	      end
	    end
	    return freq
	   
	end
  
    def pricecalc price,checkin,checkout,returnprice
	    if checkin == checkout
	      checkout = checkout + 1
	    end
	    price = price.sort_by{|a| a[:start]}
	    while checkout > checkin
	      for i in 0...price.length
	        n = 0

	        if price[i][:start]<=checkin && price[i][:end] >=checkin && price[i][:end]>=checkout-1
	          puts 0

	          n = (checkout - checkin).to_i
	            if checkout == checkin
	              n = n + 1
	            end
	          returnprice[:base_1] = n*price[i][:price][:base_1].to_i + returnprice[:base_1]
	          returnprice[:base_2] = n*price[i][:price][:base_2].to_i + returnprice[:base_2]
	          returnprice[:extraadult] = n*price[i][:price][:extraadult].to_i + returnprice[:extraadult]
	          returnprice[:extrachild] = n*price[i][:price][:extrachild].to_i + returnprice[:extrachild]
	          returnprice[:adult_breakfast] = n*price[i][:price][:adult_breakfast].to_i + returnprice[:adult_breakfast]
	          returnprice[:adult_lunch] = n*price[i][:price][:adult_lunch].to_i + returnprice[:adult_lunch]
	          returnprice[:adult_dinner] = n*price[i][:price][:adult_dinner].to_i + returnprice[:adult_dinner]
	          returnprice[:child_breakfast] = n*price[i][:price][:child_breakfast].to_i + returnprice[:child_breakfast]
	          returnprice[:child_lunch] = n*price[i][:price][:child_lunch].to_i + returnprice[:child_lunch]
	          returnprice[:child_dinner] = n*price[i][:price][:child_dinner].to_i + returnprice[:child_dinner]
	          return returnprice
	        elsif price[i][:start] <= checkin && price[i][:end] >= checkin && price[i][:end] < checkout - 1 
	          puts 1
	          n = (price[i][:end] + 1 - checkin).to_i
	          returnprice[:base_1] = n*price[i][:price][:base_1].to_i + returnprice[:base_1]
	          returnprice[:base_2] = n*price[i][:price][:base_2].to_i + returnprice[:base_2]
	          returnprice[:extraadult] = n*price[i][:price][:extraadult].to_i + returnprice[:extraadult]
	          returnprice[:extrachild] = n*price[i][:price][:extrachild].to_i + returnprice[:extrachild]
	          returnprice[:adult_breakfast] = n*price[i][:price][:adult_breakfast].to_i + returnprice[:adult_breakfast]
	          returnprice[:adult_lunch] = n*price[i][:price][:adult_lunch].to_i + returnprice[:adult_lunch]
	          returnprice[:adult_dinner] = n*price[i][:price][:adult_dinner].to_i + returnprice[:adult_dinner]
	          returnprice[:child_breakfast] = n*price[i][:price][:child_breakfast].to_i + returnprice[:child_breakfast]
	          returnprice[:child_lunch] = n*price[i][:price][:child_lunch].to_i + returnprice[:child_lunch]
	          returnprice[:child_dinner] = n*price[i][:price][:child_dinner].to_i + returnprice[:child_dinner]
	          checkin = price[i][:end] + 1

	        end
	        i = i + 1
	      end
	    end
	    return returnprice
	end
	def roomtypeFilters params,roomtypes
	    if roomtypes.length == 0
	        return roomtypes
	    end
	    basic = []
	    if params[:clothesracks] == 'true'
	      basic.push('clothesracks')
	    end
	    if params[:dryingracking] == 'true'
	      basic.push('dryingracking')
	    end
	    if params[:foldupbed] == 'true'
	      basic.push('foldupbed')
	    end
	    if params[:sofabed] == 'true'
	      basic.push('sofabed')
	    end
	    if params[:wardrobe] == 'true'
	      basic.push('wardrobe')
	    end
	    if params[:carpeted] == 'true'
	      basic.push('carpeted')
	    end
	    if params[:walkingcloset] == 'true'
	      basic.push('walkingcloset')
	    end
	    if params[:extralongbeds] == 'true'
	      basic.push('extralongbeds')
	    end
	    if params[:fireplace] == 'true'
	      basic.push('fireplace')
	    end
	    if params[:heater] == 'true'
	      basic.push('heater')
	    end
	    if params[:interconnectingrooms] == 'true'
	      basic.push('interconnectingrooms')
	    end
	    if params[:iron] == 'true'
	      basic.push('iron')
	    end

	    if params[:desk] == 'true'
	      basic.push('desk')
	    end
	    if params[:wifi] == 'true'
	      basic.push('wifi')
	    end
	    if params[:smoking] == 'true'
	      basic.push('smoking')
	    end
	    if params[:tv] == 'true'
	      basic.push('tv')
	    end
	    restroom = []
	    if params[:bathroom] == 'true'
	      restroom.push('bathroom')
	    end
	    if params[:toiletpaper] == 'true'
	      restroom.push('toiletpaper')
	    end
	    if params[:bathtub] == 'true'
	      restroom.push('bathtub')
	    end
	    if params[:shower] == 'true'
	      restroom.push('shower')
	    end
	    if params[:bathrobe] == 'true'
	      restroom.push('bathrobe')
	    end
	    if params[:freetoiletries] == 'true'
	      restroom.push('freetoiletries')
	    end
	    if params[:hairdryer] == 'true'
	      restroom.push('hairdryer')
	    end
	    if params[:spatub] == 'true'
	      restroom.push('spatub')
	    end
	    if params[:sharedbathroom] == 'true'
	      restroom.push('sharedbathroom')
	    end
	    if params[:slippers] == 'true'
	      restroom.push('slippers')
	    end
	    if params[:toilets] == 'true'
	      restroom.push('toilets')
	    end
	    if params[:geyser] == 'true'
	      restroom.push('geyser')
	    end

	    basic.each do |b|
	      queryString = "%" + b + ": '1'%"
	      if roomtypes.any?
	        roomtypes = roomtypes.where('basic like ?',queryString)
	      elsif roomtypes.length == 1
	        if roomtypes[0].basic[b.to_sym] == '0'
	          roomtypes = []
	        end
	      end
	    end
	    restroom.each do |b|
	      queryString = "%" + b + ": '1'%"
	      if roomtypes.any?
	        roomtypes = roomtypes.where('restroom like ?',queryString)
	      end
	    end
	    return roomtypes
  	end


	def order
		checkin = params[:checkin].to_date
		checkout = params[:checkout].to_date
		room_object = params[:room_object]
		hotel_id = params[:hotel_id].to_i
		@hotel = Hotel.find(hotel_id)
		@room_array = @hotel.roomtypes
		if @hotel.pricing
	       price = @hotel.pricing.price
	    end
	    @AllRoomObjects = []
	    @room_array = roomtypeFilters params,@room_array
		@room_array.each do |room|
			roomObject = {}
        	booked = checkRoomEligiblity(room,checkin,checkout,@hotel)
	        if price != nil && price[room.id] && booked >= 0
	          returnprice = {:base_1=>0, :base_2=>0, :extraadult=>0, :extrachild=>0, :adult_breakfast=>0, :adult_lunch=>0,:adult_dinner=>0, :child_dinner=>0, :child_breakfast=>0,:child_lunch=>0}
	          returnprice = pricecalc(price[room.id],checkin,checkout,returnprice)
	          roomObject = {id: room.id,free: room.rooms - booked, capacity: room.basechildren + room.baseadults , baseadults: room.baseadults, basechildren: room.basechildren , maximumadults: room.maximumadults , maximumchildren: room.maximumchildren ,used: 0,price: returnprice,extrabed: room.maximumguests-room.basechildren - room.baseadults}
	          if room_object[room.id.to_s] != nil
	          	roomObject[:used] = room_object[room.id.to_s].length
	          end
	          @AllRoomObjects = @AllRoomObjects.push(roomObject)
	        end
		end
	end
	def bookingform

	end
	def bookinglog startdate,enddate,roomtype_id,hotel_id
		bookinglog = Bookinglog.where(hotel_id: hotel_id.to_i).first
		booking = bookinglog.booking[roomtype_id.to_i]
		booking = booking.sort_by{|a| a[:start]}
		if startdate >= enddate
				return booking
			end
			if startdate < booking[0][:start]
				return booking
			end
		i = 0
		while 1
		  if booking[i][:start] == startdate && booking[i][:end] == enddate
		    
		    booking[i][:frequency] = booking[i][:frequency] + 1
		    break

		  elsif booking[i][:start] == startdate && booking[i][:end] > enddate
		    
		    oldfreq = booking[i][:frequency]
		    olddate = booking[i][:end]
		    booking[i][:end] = enddate
		    booking[i][:frequency] = booking[i][:frequency] + 1
		    newObj = {start: enddate,end: olddate,frequency: oldfreq,typename:booking[i][:typename],total:booking[i][:total]}
		    booking.insert(i+1,newObj)
		    break

		  elsif booking[i][:start] == startdate && booking[i][:end] < enddate

		    oldfreq = booking[i][:frequency]
		    olddate = booking[i][:end]
		    booking[i][:frequency] = booking[i][:frequency] + 1
		    startdate = olddate

		  elsif booking[i][:start] < startdate && booking[i][:end] > enddate
		    
		    olddate = booking[i][:end]
		    oldfreq = booking[i][:frequency]
		    booking[i][:end] = startdate
		    newObj1 = {start: startdate,end: enddate,frequency: oldfreq + 1,typename:booking[i][:typename],total:booking[i][:total]}
		    newObj2 = {start: enddate,end: olddate,frequency: oldfreq,typename:booking[i][:typename],total:booking[i][:total]}
		    booking.insert(i+1,newObj1)
		    i = i + 1
		    booking.insert(i+1,newObj2)
		    break

		  elsif booking[i][:start] < startdate && startdate < booking[i][:end] && booking[i][:end] == enddate
		   
		    olddate = booking[i][:end]
		    oldfreq = booking[i][:frequency]
		    booking[i][:end] = startdate
		    newObj1 = {start: startdate,end: enddate,frequency: oldfreq + 1,typename:booking[i][:typename],total:booking[i][:total]}
		    booking.insert(i+1,newObj1)
		    break

		  elsif booking[i][:start] < startdate && startdate < booking[i][:end] && booking[i][:end] < enddate
		    
		    olddate = booking[i][:end]
		    oldfreq = booking[i][:frequency]
		    booking[i][:end] = startdate
		    newObj1 = {start: startdate,end: olddate,frequency: oldfreq + 1,typename:booking[i][:typename],total:booking[i][:total]}
		    booking.insert(i+1,newObj1)
		    startdate = olddate
		    i = i + 1

		  end
		  i = i + 1
		  if i == booking.length
		    break
		  end
		end
		return booking
	end
	def testing
	    startdate = Date.new(params[:startdate].split('-')[0].to_i,params[:startdate].split('-')[1].to_i,params[:startdate].split('-')[2].to_i)
	    enddate = Date.new(params[:enddate].split('-')[0].to_i,params[:enddate].split('-')[1].to_i,params[:enddate].split('-')[2].to_i)
	    hotel_id = params[:hotel_id].to_i
	    roomtype_id = params[:roomtype_id].to_i
	    booking = bookinglog( startdate ,enddate ,hotel_id ,roomtype_id )
	    book = Bookinglog.where(hotel_id: hotel_id).first
	    book.booking[roomtype_id] = booking
	    puts booking
	    # booking = [{start: Date.today-1,end: Date.today + 36523,frequency: 0,typename: Roomtype.find(roomtype_id).typename,total: Roomtype.find(roomtype_id).rooms}]
	    # puts booking
	    # book.booking[roomtype_id] = booking
	    book.save
	    return redirect_to '/bookings/bookingform'
	end
end

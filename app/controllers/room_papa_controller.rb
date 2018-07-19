class RoomPapaController < ApplicationController
  before_action :authenticate_user!, except: [:default,:users,:main,:search,:hotels,:filters,:hotel_info,:room_page]
  def default
    render file: "#{Rails.root}/public/404", status: :not_found
  end
  def index

  end
  def users
    return redirect_to '/users/sign_up'
  end
  def main

  end
  def search
  end
  
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
  def hotelFilters params,hotels
      if hotels.length == 0
        return hotels
      end
      basic = []

      if params[:bar] == 'true'
        basic.push('bar')
      end
      if params[:gym] == 'true'
        basic.push('gym')
      end
      if params[:lift] == 'true'
        basic.push('lift')
      end
      if params[:parking] == 'true'
        basic.push('parking')
      end
      if params[:restaurant] == 'true'
        basic.push('restaurant')
      end
      if params[:spa] == 'true'
        basic.push('spa')
      end
      if params[:swimmingpool] == 'true'
        basic.push('swimmingpool')
      end
      food = []

      if params[:barbecue] == 'true'
        food.push('barbecue')
      end
      if params[:coffeemachine] == 'true'
        food.push('coffeemachine')
      end
      if params[:diningarea] == 'true'
        food.push('diningarea')
      end
      if params[:diningtable] == 'true'
        food.push('diningtable')
      end
      if params[:highchair] == 'true'
        food.push('highchair')
      end
      if params[:kitchnette] == 'true'
        food.push('kitchnette')
      end
      if params[:microwave] == 'true'
        food.push('microwave')
      end
      if params[:outdoordiningarea] == 'true'
        food.push('outdoorfurniture')
      end
      if params[:outdoorfurniture] == 'true'
        food.push('outdoorfurniture')
      end
      if params[:refrigerator] == 'true'
        food.push('refrigerator')
      end
      if params[:stovetop] == 'true'
        food.push('stovetop')
      end
       if params[:teacoffeemachine] == 'true'
        food.push('teacoffeemachine')
      end
       if params[:toaster] == 'true'
        food.push('toaster')
      end

      disability = []

       if params[:elevator] == 'true'
        disability.push('elevator')
      end
      if params[:staircaseonly] == 'true'
        disability.push('staircaseonly')
      end
      if params[:grabrailstoilet] == 'true'
        disability.push('grabrailstoilet')
      end
      if params[:groundfloor] == 'true'
        disability.push('groundfloor')
      end
      if params[:wheelchair] == 'true'
        disability.push('wheelchair')
      end
      
      basic.each do |b|
        queryString ="%" + b + ": '1'%"
        if hotels.any?
          hotels = hotels.where('basic like ?',queryString)
        end
      end
      food.each do |f|
        queryString = "%" + f + ": '1'%"
        if hotels.any?
          hotels = hotels.where('food like ?',queryString)
        end
      end
      disability.each do |d|
        queryString = "%" + d + ": '1'%"
        if hotels.any?
          hotels = hotels.where('disability like ?',queryString)
        end
      end
      return hotels
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

  def hotels
    count = 0
    @rooms = []
    @hotels = Hotel.all
    if params[:rating] != nil
      @hotels = @hotels.where('rating >=?',params[:rating].to_f)
    end
    if params[:city] != nil
      city = '%' + params[:city] +'%'
      if @hotels.any? 
        @hotels = @hotels.where('city LIKE ? or hotelname LIKE ?', city,city)
      end
    end
    checkin = Date.new(params[:checkin].split('-')[0].to_i,params[:checkin].split('-')[1].to_i,params[:checkin].split('-')[2].to_i)
    checkout = Date.new(params[:checkout].split('-')[0].to_i,params[:checkout].split('-')[1].to_i,params[:checkout].split('-')[2].to_i)
    
    if @hotels.any?
      @hotels =  hotelFilters(params,@hotels)
    end

    @hotels.each do |hotel|
      price = nil
      if hotel.pricing
       price = hotel.pricing.price
     end
      people = []
      i = 0
      params[:data_value].each do |data|
        person = { capacity:data[1][:Adult].to_i  + data[1][:BigChild].to_i ,adults:  data[1][:Adult].to_i , children:  data[1][:BigChild].to_i ,found: false}
        
        people = people.insert(i,person)
        i = i + 1
      end
      people = people.sort_by{|a| a[:capacity]}.reverse
      rm = hotel.roomtypes
      rm = roomtypeFilters(params,rm)

      hotelRoomFree = []
      roomCounter = 0
      n = checkout - checkin + 1
      rm.each do |room|
        booked = checkRoomEligiblity(room,checkin,checkout,hotel)
        roomObject = {}
        if price != nil && price[room.id] && booked >= 0
          returnprice = {:base_1=>0, :base_2=>0, :extraadult=>0, :extrachild=>0, :adult_breakfast=>0, :adult_lunch=>0,:adult_dinner=>0, :child_dinner=>0, :child_breakfast=>0,:child_lunch=>0}
          returnprice = pricecalc(price[room.id],checkin,checkout,returnprice)
          roomObject = {id: room.id,free: room.rooms - booked, capacity: room.basechildren + room.baseadults , baseadults: room.baseadults, basechildren: room.basechildren , maximumadults: room.maximumadults , maximumchildren: room.maximumchildren ,used: 0,price: returnprice,extrabed: room.maximumguests-room.basechildren - room.baseadults}
          hotelRoomFree = hotelRoomFree.insert(roomCounter,roomObject)
          roomCounter = roomCounter + 1
        end

      end
      hotelRoomFree = hotelRoomFree.sort_by{|a| [a[:capacity]]}
      room = []
      for i in 0...people.length
        if people[i][:found] == false 
          for j in 0...hotelRoomFree.length
            if people[i][:capacity] <= hotelRoomFree[j][:capacity] && people[i][:adults]<=hotelRoomFree[j][:maximumadults] && people[i][:children]<=hotelRoomFree[j][:maximumchildren] && people[i][:found] == false && hotelRoomFree[j][:free] - hotelRoomFree[j][:used] > 0
              pusher = { id: hotelRoomFree[j][:id] ,free: hotelRoomFree[j][:free] ,capacity: hotelRoomFree[j][:capacity] ,baseadults: hotelRoomFree[j][:baseadults] ,basechildren: hotelRoomFree[j][:basechildren] ,maximumadults: hotelRoomFree[j][:maximumadults] ,maximumchildren: hotelRoomFree[j][:maximumchildren], used: hotelRoomFree[j][:used] + 1 ,price: hotelRoomFree[j][:price],extrabed: hotelRoomFree[j][:extrabed] ,requiredAdults: people[i][:adults] , requiredChildren: people[i][:children]}
              room = room.insert(i,pusher)
              people[i][:found] = true
              hotelRoomFree[j][:used] = hotelRoomFree[j][:used] + 1
            end
          end
        end

        if people[i][:found] == false 
          for j in 0...hotelRoomFree.length
            if people[i][:capacity] <= hotelRoomFree[j][:capacity] + hotelRoomFree[j][:extrabed] && people[i][:adults]<=hotelRoomFree[j][:maximumadults] && people[i][:children]<=hotelRoomFree[j][:maximumchildren] && people[i][:found] == false && hotelRoomFree[j][:free] - hotelRoomFree[j][:used] > 0
              pusher = { id: hotelRoomFree[j][:id] ,free: hotelRoomFree[j][:free] ,capacity: hotelRoomFree[j][:capacity] ,baseadults: hotelRoomFree[j][:baseadults] ,basechildren: hotelRoomFree[j][:basechildren] ,maximumadults: hotelRoomFree[j][:maximumadults] ,maximumchildren: hotelRoomFree[j][:maximumchildren], used: hotelRoomFree[j][:used] + 1 ,price: hotelRoomFree[j][:price],extrabed: hotelRoomFree[j][:extrabed] ,requiredAdults: people[i][:adults] , requiredChildren: people[i][:children]}
              
              room = room.insert(i,pusher)
              people[i][:found] = true
              hotelRoomFree[j][:used] = hotelRoomFree[j][:used] + 1
            end
          end
        end

        if people[i][:found] == false
          break
        end
      end
      if room.length == people.length
        @rooms = @rooms.insert(count,room)
        count = count + 1
        puts count
      else
      end
    end 
    if request.xhr?
      render :json=>{
        :url_link => request.url
      }
    end
  end                                                                                #def hotels

  def filters
    
  end

  def hotel_info

  end

  def room_page
    
  end

  def deleteimage
    roomtype = Roomtype.find_by_id(params[:roomtype])
    count = 0
    @file = params[:file]
    roomtype.images.each do |image|
      if image.file.path.split("/").last == params[:file]
        break;
      end
      count = count + 1
    end
    remain_images = roomtype.images # copy initial avatars
    delete_image = remain_images.delete_at(count) # delete the target image
    delete_image.try(:remove!) # delete image
    roomtype.images = remain_images # re-assign back
    roomtype.save
    respond_to do |format|
      format.html { redirect_to '/roomtypes/'+roomtype.id.to_s+'/edit' }
      format.js {}
    end
  end
end                                                                                 #class























 


class RoomPapaController < ApplicationController
  before_action :authenticate_user!, except: [:users,:main,:search,:hotels,:filters,:hotel_info,:room_page]

  def index

  end
  def users
    return redirect_to '/users/sign_up'
  end
  def main

  end
  def search
  end
  
  def checkRoomEligiblity(room,hm,checkin,checkout)
    if room.bookings
      room.bookings.each do |b|
        ci = b.checkin
        co = b.checkout

        if ci>=checkin && co<=checkout
          date = ci
            while date<co
              hm[date] +=  b.rooms
              date += 1
            end
        elsif ci<=checkin && co>=checkin && co<=checkout
            date = checkin
            while date<co
              hm[date] +=  b.rooms
              date += 1
            end
        elsif ci>=checkin && ci<=checkout && co>=checkout
            date = ci
            while date<checkout
                hm[date] += b.rooms
                date += 1
            end
        elsif ci<=checkin && co>=checkout
            date = checkin
            while date<checkout
              hm[date] +=  b.rooms
              date += 1
            end
        end
      end
    end
   
  end
  
  def pricecalc price,checkin,checkout,returnprice
    if checkin == checkout
      checkout = checkout + 1
    end
    n = checkout - checkin + 1
    while checkout > checkin
      price.each do |p|
        if p[:start]<=checkin&&p[:end]>=checkout
          returnprice[:base_1] = p[:price][:base_1].to_i + returnprice[:base_1]
          returnprice[:base_2] = p[:price][:base_2].to_i + returnprice[:base_2]
          returnprice[:extraadult] = p[:price][:extraadult].to_i + returnprice[:extraadult]
          returnprice[:extrachild] = p[:price][:extrachild].to_i + returnprice[:extrachild]
          returnprice[:adult_breakfast] = p[:price][:adult_breakfast].to_i + returnprice[:adult_breakfast]
          returnprice[:adult_lunch] = p[:price][:adult_lunch].to_i + returnprice[:adult_lunch]
          returnprice[:adult_dinner] = p[:price][:adult_dinner].to_i + returnprice[:adult_dinner]
          returnprice[:child_breakfast] = p[:price][:child_breakfast].to_i + returnprice[:child_breakfast]
          returnprice[:child_lunch] = p[:price][:child_lunch].to_i + returnprice[:child_lunch]
          returnprice[:child_dinner] = p[:price][:child_dinner].to_i + returnprice[:child_dinner]
          break
        end
      end
      checkin = checkin+1
    end
  end

  def hotels
    @rooms = []
    count = 0
    
    city = '%' + params[:city] +'%'
    @hotels = Hotel.where('city LIKE ? or hotelname LIKE ?', city,city)
    checkin = Date.new(params[:checkin].split('-')[0].to_i,params[:checkin].split('-')[1].to_i,params[:checkin].split('-')[2].to_i)
    checkout = Date.new(params[:checkout].split('-')[0].to_i,params[:checkout].split('-')[1].to_i,params[:checkout].split('-')[2].to_i)
    n = (checkout-checkin).to_s.split('/')[0].to_i
    
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

      hotelRoomFree = []
      roomCounter = 0

      rm.each do |room|
        hm = {}
        i = 0
        while i<n
          c = checkin + i
          hm[c] = 0
          i += 1
        end
        checkRoomEligiblity(room,hm,checkin,checkout)
        i = 0
        booked = -1
        while i<n
          c = checkin + i
          if booked<hm[c]
            booked = hm[c]
          end
          i+=1
        end
        roomObject = {}
        if price != nil && price[room.id]
          returnprice = {:base_1=>0, :base_2=>0, :extraadult=>0, :extrachild=>0, :adult_breakfast=>0, :adult_lunch=>0,:adult_dinner=>0, :child_dinner=>0, :child_breakfast=>0,:child_lunch=>0}
          pricecalc(price[room.id],checkin,checkout,returnprice)
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























 


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
  
  def hotels
    byebug
    @rooms = []
    count = 0
    
    city = '%' + params[:city] +'%'

    @hotels = Hotel.where('city LIKE ? or hotelname LIKE ?', city,city)
    checkin = Date.new(params[:checkin].split('-')[0].to_i,params[:checkin].split('-')[1].to_i,params[:checkin].split('-')[2].to_i)
    checkout = Date.new(params[:checkout].split('-')[0].to_i,params[:checkout].split('-')[1].to_i,params[:checkout].split('-')[2].to_i)
    n = (checkout-checkin).to_s.split('/')[0].to_i
    @hotels.each do |hotel|
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
        if room.pricing
          roomObject = {id: room.id,free: room.rooms - booked, capacity: room.basechildren + room.baseadults , baseadults: room.baseadults, basechildren: room.basechildren , maximumadults: room.maximumadults , maximumchildren: room.maximumchildren ,used: 0,basePrice: room.pricing.baseprice,ebprice: 90,extrabed: room.extrabed}
          hotelRoomFree = hotelRoomFree.insert(roomCounter,roomObject)
          roomCounter = roomCounter + 1
        end

      end
      hotelRoomFree = hotelRoomFree.sort_by{|a| [a[:capacity],a[:basePrice]]}
      room = []
      for i in 0...people.length
        
        if people[i][:found] == false 
          for j in 0...hotelRoomFree.length
            if people[i][:capacity] <= hotelRoomFree[j][:capacity] && people[i][:adults]<=hotelRoomFree[j][:maximumadults] && people[i][:children]<=hotelRoomFree[j][:maximumchildren] && people[i][:found] == false && hotelRoomFree[j][:free] - hotelRoomFree[j][:used] > 0
              pusher = { id: hotelRoomFree[j][:id] ,free: hotelRoomFree[j][:free] ,capacity: hotelRoomFree[j][:capacity] ,baseadults: hotelRoomFree[j][:baseadults] ,basechildren: hotelRoomFree[j][:basechildren] ,maximumadults: hotelRoomFree[j][:maximumadults] ,maximumchildren: hotelRoomFree[j][:maximumchildren], used: hotelRoomFree[j][:used] + 1 ,basePrice: hotelRoomFree[j][:basePrice] ,ebprice: hotelRoomFree[j][:ebprice] ,extrabed: hotelRoomFree[j][:extrabed] ,requiredAdults: people[i][:adults] , requiredChildren: people[i][:children]}
              room = room.insert(i,pusher)
              people[i][:found] = true
              hotelRoomFree[j][:used] = hotelRoomFree[j][:used] + 1
            end
          end
        end

        if people[i][:found] == false 
          for j in 0...hotelRoomFree.length
            if people[i][:capacity] <= hotelRoomFree[j][:capacity] + hotelRoomFree[j][:extrabed] && people[i][:adults]<=hotelRoomFree[j][:maximumadults] && people[i][:children]<=hotelRoomFree[j][:maximumchildren] && people[i][:found] == false && hotelRoomFree[j][:free] - hotelRoomFree[j][:used] > 0
              pusher = { id: hotelRoomFree[j][:id] ,free: hotelRoomFree[j][:free] ,capacity: hotelRoomFree[j][:capacity] ,baseadults: hotelRoomFree[j][:baseadults] ,basechildren: hotelRoomFree[j][:basechildren] ,maximumadults: hotelRoomFree[j][:maximumadults] ,maximumchildren: hotelRoomFree[j][:maximumchildren], used: hotelRoomFree[j][:used] + 1 ,basePrice: hotelRoomFree[j][:basePrice] ,ebprice: hotelRoomFree[j][:ebprice] ,extrabed: hotelRoomFree[j][:extrabed] ,requiredAdults: people[i][:adults] , requiredChildren: people[i][:children]}
              
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
    # return request.url
    if request.xhr?
      render :json=>{
        :url_link => request.url
      }
    end
  end                                                                                #def hotels

  def filters
    url = request.referer
    url = url.split('&')
    if params[:min_price]&&params[:max_price]
      m1 = params[:min_price].to_f
      m2 = params[:max_price].to_f
      if m1 > m2
        params[:max_price] = m1.to_s
        params[:min_price] = m2.to_s
      end
    end
    counter = 3
    if params[:min_price]
      url[counter] = "min_price="+ params[:min_price]
    else
      url[counter] = "min_price=0"
    end
    counter = counter + 1
    if params[:max_price]
      url[counter] = "max_price="+ params[:max_price]
    else
      url[counter] = "max_price=8000"
    end
    counter = counter + 1
    if params[:wifi]
      url[counter] = "wifi=" + params[:wifi]
    else
      url[counter] = "wifi=off"
    end
    counter = counter + 1
    if params[:geyser]
      url[counter] = "geyser=" + params[:geyser]
    else
      url[counter] = "geyser=off"
    end
    counter = counter + 1
    if params[:ac]
      url[counter] = "ac=" + params[:ac]
    else
      url[counter] = "ac=off"
    end
    counter = counter + 1
    if params[:cooler]
      url[counter] = "cooler=" + params[:cooler]
    else
      url[counter] = "cooler=off"
    end
    counter = counter + 1
    if params[:fan]
      url[counter] = "fan=" + params[:fan]
    else
      url[counter] = "fan=off"
    end
    counter = counter + 1
    if params[:smoking]
      url[counter] = "smoking=" + params[:smoking]
    else
      url[counter] = "smoking=off"
    end
    counter = counter + 1
    if params[:balcony]
      url[counter] = "balcony=" + params[:balcony]
    else
      url[counter] = "balcony=off"
    end
    counter = counter + 1
    if params[:bathroom]
      url[counter] = "bathroom=" + params[:bathroom]
    else
      url[counter] = "bathroom=off"
    end
    counter = counter + 1
    if params[:tv]
      url[counter] = "tv=" + params[:tv]
    else
      url[counter] = "tv=off"
    end
    counter = counter + 1
    if params[:familyrooms]
      url[counter] = "familyrooms=" + params[:familyrooms]
    else
      url[counter] = "familyrooms=off"
    end
    counter = counter + 1
    if params[:pwd]
      url[counter] = "pwd=" + params[:pwd]
    elsecounter
      url[i] = "pwd=off"
    end
    counter = counter + 1
    if params[:laundry]
      url[counter] = "laundry=" + params[:laundry]
    else
      url[counter] = "laundry=off"
    end
    counter = counter + 1
    if params[:kettle]
      url[counter] = "kettle=" +params[:kettle]
    else
      url[counter] = "kettle=off"
    end
    counter = counter + 1
    if params[:parking]
      url[counter] = "parking=" + params[:parking]
    else
      url[counter] = "parking=off"
    end


    counter = counter + 1

    if params[:gym]
      url[counter] = "gym=" + params[:gym]
    else
      url[counter] = "gym=off"
    end
    counter = counter + 1
    if params[:spa]
      url[counter] = "spa=" + params[:spa]
    else
      url[counter] = "spa=off"
    end
    counter = counter + 1
    if params[:pool]
      url[counter] = "pool=" +  params[:pool]
    else
      url[counter] = "pool=off"
    end
    counter = counter + 1
    if params[:bar]
      url[counter] = "bar=" + params[:bar]
    else
      url[counter] = "bar=off"
    end
    counter = counter + 1
    if params[:lift]
      url[counter] = "lift=" + params[:lift]
    else
      url[counter] = "lift=off"
    end
    counter = counter + 1
    if params[:restaurant]
      url[counter] = "restaurant=" + params[:restaurant]
    else
      url[counter] = "restaurant=off"
    end
    rrr = '';
    i = url.length;
    url.each do |u|
      i = i - 1
      if i == 0
        rrr = rrr + u;
      else
        rrr = rrr + u + '&';
      end
    end
    return redirect_to rrr
    
  end

  def hotel_info

  end

  def room_page
    
  end
end                                                                                 #class























 


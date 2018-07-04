def hotels
    city = '%' + params[:city] +'%'
    
    adults = (params[:adults].to_f/params[:rooms].to_f).ceil
    children = (params[:children].to_f/params[:rooms].to_f).ceil

    @hotels = Hotel.where('city LIKE ? or hotelname LIKE ?', city,city)
     if params[:parking] == 'on' && @hotels != nil
      @hotels = @hotels.where(parking: true)
    end
     if params[:gym] == 'on' && @hotels != nil
      @hotels = @hotels.where(gym: true)
    end
    if params[:spa] == 'on' && @hotels != nil
      @hotels = @hotels.where(spa: true)
    end
    if params[:pool] == 'on' && @hotels != nil
      @hotels = @hotels.where(pool: true)
    end
    if params[:bar] == 'on' && @hotels != nil
      @hotels = @hotels.where(bar: true)
    end
    if params[:lift] == 'on' && @hotels != nil
      @hotels = @hotels.where(lift: true)
    end
    if params[:restaurant] == 'on' && @hotels != nil
      @hotels = @hotels.where(restaurant: true)
    end

    checkin = Date.new(params[:checkin].split('-')[0].to_i,params[:checkin].split('-')[1].to_i,params[:checkin].split('-')[2].to_i)
    
    checkout = Date.new(params[:checkout].split('-')[0].to_i,params[:checkout].split('-')[1].to_i,params[:checkout].split('-')[2].to_i)
    n = (checkout-checkin).to_s.split('/')[0].to_i

    @rooms = []
    count = 0
      
    @hotels.each do |hotel|
      rm = hotel.roomtypes
      for i in 6..19
          if params[:wifi] == 'on' && rm != nil
            rm = rm.where(wifi: true)
          end
          if params[:geyser] == 'on' && rm != nil
            rm = rm.where(geyser: true)
          end
          if params[:ac] == 'on' && rm != nil
            rm = rm.where(ac: true)
          end
          if params[:cooler] == 'on' && rm != nil
            rm = rm.where(cooler: true)
          end
          if params[:fan] == 'on' && rm != nil
            rm = rm.where(fan: true)
          end
          if params[:smoking] == 'on' && rm != nil
            rm = rm.where(smoking: true)
          end
          if params[:balcony] == 'on' && rm != nil
            rm = rm.where(balcony: true)
          end
          if params[:bathrm] == 'on' && rm != nil
            rm = rm.where(bathrm: true)
          end
          if params[:tv] == 'on' && rm != nil
            rm = rm.where(tv: true)
          end
          if params[:familyrms] == 'on' && rm != nil
            rm = rm.where(familyrms: true)
          end
          if params[:pwd] == 'on' && rm != nil
            rm = rm.where(pwd: true)
          end
          if params[:laundry] == 'on' && rm != nil
            rm = rm.where(laundry: true)
          end
          if params[:kettle] == 'on' && rm != nil
            rm = rm.where(kettle: true)
          end
      end

      
      rm.each do |room|
        if room.pricing && room.pricing.baseprice>=params[:min_price].to_i&&room.pricing.baseprice<=params[:max_price].to_i
          hmw = {}
          i = 0
          while i<n
            c = checkin + i
            hmw[c] = 0
            i+=1
          end
          hm = {}
          i = 0
          while i<n
            c = checkin + i
            hm[c] = 0
            i += 1
          end
      
          if room.extrabed == true
            if (room.adults<adults||room.children<children)&&((room.adults+1>=adults&&room.children>=children)||(room.adults>=adults&&room.children+1>=children))
              checker = room.pricing.baseprice+room.pricing.ebpricing
              if checker>=params[:min_price].to_i&&checker<=params[:max_price].to_i
                checkRoomEligiblity(room,hmw,checkin,checkout)
                i = 0
                booked = -1
                while i<n
                  c = checkin + i
                  if booked<hmw[c]
                    booked = hmw[c]
                  end
                  i+=1
                end

                if room.rooms-booked>=params[:rooms].to_i
                  @rooms[count] = room
                  count = count + 1
                end
              end
            end
          end
          if room.adults>=adults && room.children>=children
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
            if room.rooms-booked>=params[:rooms].to_i
              @rooms[count] = room
              count = count + 1
            end
          end
        end    
      end        
    end 
   
  end                                                                               #def hotels

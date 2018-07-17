class PricingsController < ApplicationController
  # before_action :authenticate_user!
  # protect_from_forgery except: :create,:update
  # GET /pricings/new
  def new
    
  end

  # GET /pricings/1/edit
  def edit
    @pricing = Pricing.where(hotel_id: current_user.hotel.id).first
  end

  # POST /pricings
  # POST /pricings.json
  def create
    hotel = current_user.hotel
    if hotel.pricing
      if hotel.id == Roomtype.find_by_id(params[:roomtype_id]).hotel_id
        pricing = Pricing.where(hotel_id: hotel.id).first
        price = Hash.new
        price = pricing.price
        room = params[:roomtype_id].to_i
        price[room] = []
        price[room].push({price: params[:price],start: Date.today,end: Date.today+36524})



        pricing.price = price
        pricing.save
          if request.xhr?
            render :json=>{
              :success=> 'true'
            }
          end
        return
      end
    else
      if hotel.id == Roomtype.find_by_id(params[:roomtype_id]).hotel_id
        pricing = Pricing.new
        pricing.hotel_id = hotel.id
        price = Hash.new
        room = params[:roomtype_id].to_i
        price[room] = []
        price[room].push({price: params[:price],start: Date.today,end: Date.today+36524})
        pricing.price = {}
        pricing.price = price
        pricing.save
        if request.xhr?
          render :json=>{
            :success=> 'true'
          }
        end
        return
      end
    end
    
   
  end

  # PATCH/PUT /pricings/1
  # PATCH/PUT /pricings/1.json
  def update
    month = {'Jan': 1,'Feb': 2,'Mar': 3,'Apr': 4,'May': 5,'Jun': 6,'Jul': 7,'Aug': 8,'Sep': 9,'Oct': 10,'Nov': 11,'Dec': 12}
    if current_user.hotel.id == Roomtype.find_by_id(params[:roomtype_id]).hotel_id
      price = []
      params[:price].each do |p|
        startDate = p[1][:start].split(' ')[2].to_i
        startMonth = month[p[1][:start].split(' ')[1].to_sym]
        startYear = p[1][:start].split(' ')[3].to_i
        endDate = p[1][:end].split(' ')[2].to_i
        endMonth = month[p[1][:end].split(' ')[1].to_sym]
        endYear = p[1][:end].split(' ')[3].to_i
        priceObj = p[1][:price]
        price.push(price: priceObj,start: Date.new(startYear,startMonth,startDate),end: Date.new(endYear,endMonth,endDate))
      end
      pricing = current_user.hotel.pricing
      pricing.price[params[:roomtype_id].to_i] = price
      pricing.save
      
      if request.xhr?
          render :json=>{
            :success=> 'true'
          }
      end

    end
    # respond_to do |format|
    #   if @pricing.update(pricing_params)

    #     format.html { redirect_to '/roomtypes', notice: 'Pricing was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @pricing }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @pricing.errors, status: :unprocessable_entity }
    #   end
    # end
  end
   
  def bookinglog startdate,enddate,roomtype_id,hotel_id
    bookinglog = Bookinglog.where(hotel_id: hotel_id.to_i).first
    booking = bookinglog.booking[roomtype_id.to_i]
    booking = booking.sort_by{|a| a[:start]}
    i = 0
    while 1
      if booking[i][:start] == startdate && booking[i][:end] == enddate
        
        puts 1
        booking[i][:frequency] = booking[i][:frequency] + 1
        break

      elsif booking[i][:start] == startdate && booking[i][:end] > enddate
        
        puts 2
        oldfreq = booking[i][:frequency]
        olddate = booking[i][:end]
        booking[i][:end] = enddate
        booking[i][:frequency] = booking[i][:frequency] + 1
        newObj = {start: enddate,end: olddate,frequency: oldfreq}
        booking.insert(i+1,newObj)
        break

      elsif booking[i][:start] == startdate && booking[i][:end] < enddate
        puts 3
        oldfreq = booking[i][:frequency]
        olddate = booking[i][:end]
        booking[i][:frequency] = booking[i][:frequency] + 1
        startdate = olddate

      elsif booking[i][:start] < startdate && booking[i][:end] > enddate
        
        puts 4
        olddate = booking[i][:end]
        oldfreq = booking[i][:frequency]
        booking[i][:end] = startdate
        newObj1 = {start: startdate,end: enddate,frequency: oldfreq + 1}
        newObj2 = {start: enddate,end: olddate,frequency: oldfreq}
        booking.insert(i+1,newObj1)
        i = i + 1
        booking.insert(i+1,newObj2)
        break

      elsif booking[i][:start] < startdate && startdate < booking[i][:end] && booking[i][:end] == enddate
       
        puts 5
        olddate = booking[i][:end]
        oldfreq = booking[i][:frequency]
        booking[i][:end] = startdate
        newObj1 = {start: startdate,end: enddate,frequency: oldfreq + 1}
        booking.insert(i+1,newObj1)
        break

      elsif booking[i][:start] < startdate && startdate < booking[i][:end] && booking[i][:end] < enddate
        
        puts 6
        olddate = booking[i][:end]
        oldfreq = booking[i][:frequency]
        booking[i][:end] = startdate
        newObj1 = {start: startdate,end: olddate,frequency: oldfreq + 1}
        booking.insert(i+1,newObj1)
        startdate = olddate
        i = i + 1
        
      else
        
        puts 0

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
     # booking = [{start:  Date.today-1,end: Date.today+36523,frequency: 0}]
     # book.booking[roomtype_id] = booking
    puts booking
    byebug
    book.save

    return redirect_to '/bookings/bookingform'
  end

end


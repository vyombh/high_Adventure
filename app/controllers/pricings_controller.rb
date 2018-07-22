class PricingsController < ApplicationController
  # before_action :authenticate_user!
  # protect_from_forgery except: :create,:update
  # GET /pricings/new
  def new
    Roomtype.find(params[:room_id])
    rescue ActiveRecord::RecordNotFound  
        return render file: "#{Rails.root}/public/500", status: :not_found
  end

  # GET /pricings/1/edit
  def edit
    @pricing = Pricing.where(hotel_id: current_user.hotel.id).first
    
    Roomtype.find(params[:room_id])
    rescue ActiveRecord::RecordNotFound  
        return render file: "#{Rails.root}/public/500", status: :not_found
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
  end
   def show
    @pricing = nil
    if current_user.hotel && current_user.hotel.roomtypes.any? && current_user.hotel.pricing
      @pricing = current_user.hotel.pricing.price
      keys = @pricing.keys
      @room_names = [];
      keys.each do |key|
        @room_names.push(Roomtype.find(key).typename);
      end
    end
  end
 

end


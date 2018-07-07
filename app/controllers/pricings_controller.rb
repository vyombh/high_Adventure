class PricingsController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: :create
  # GET /pricings/new
  def new
    
  end

  # GET /pricings/1/edit
  def edit
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
    respond_to do |format|
      if @pricing.update(pricing_params)

        format.html { redirect_to '/roomtypes', notice: 'Pricing was successfully updated.' }
        format.json { render :show, status: :ok, location: @pricing }
      else
        format.html { render :edit }
        format.json { render json: @pricing.errors, status: :unprocessable_entity }
      end
    end
  end
   
end

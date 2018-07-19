class RoomtypesController < ApplicationController
  before_action :set_roomtype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /roomtypes
  # GET /roomtypes.json
  def index
    @roomtypes = Roomtype.all
  end

  # GET /roomtypes/1
  # GET /roomtypes/1.json
  def show
  end

  # GET /roomtypes/new
  def new
    @roomtype = Roomtype.new
  end

  # GET /roomtypes/1/edit
  def edit
    
  end

  # POST /roomtypes
  # POST /roomtypes.json
  def create
    @roomtype = Roomtype.new(roomtype_params)
    if roomtype_params[:basechildren] && roomtype_params[:baseadults]
      @roomtype.extrabed =  roomtype_params[:maximumguests].to_i - roomtype_params[:basechildren].to_i - roomtype_params[:baseadults].to_i
    end
    respond_to do |format|
      if @roomtype.save
        hotel = current_user.hotel
        if hotel.bookinglog
          if hotel.id == @roomtype.hotel_id
            bookinglog = Bookinglog.where(hotel_id: hotel.id).first
            booking = Hash.new
            booking = bookinglog.booking
            room = @roomtype.id.to_i
            booking[room] = []
            booking[room].push({start: Date.today,end: Date.today+36524,frequency: 0,typename: @roomtype.typename,total: @roomtype.rooms})
            bookinglog.booking = booking
            bookinglog.save
          end
        else
          if hotel.id == @roomtype.hotel_id
            bookinglog = Bookinglog.new
            bookinglog.hotel_id = hotel.id
            book = Hash.new
            room = @roomtype.id.to_i
            book[room] = []
            book[room].push({start: Date.today,end: Date.today+36524,frequency: 0})
            bookinglog.booking = book
            bookinglog.save
          end
        end
        format.html { redirect_to '/pricings/new?room_id='+@roomtype.id.to_s, notice: 'room type has been defined.' }
        format.json { render :show, status: :created, location: @roomtype }
      else
        format.html { render :new }
        format.json { render json: @roomtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roomtypes/1
  # PATCH/PUT /roomtypes/1.json
  def update
    if roomtype_params[:images]
      @roomtype.images = @roomtype.images + roomtype_params[:images]
    end
    if roomtype_params[:basic]
      @roomtype.basic = roomtype_params[:basic]
    end
    if roomtype_params[:view]
      @roomtype.view = roomtype_params[:view]
    end
    if roomtype_params[:services]
      @roomtype.services = roomtype_params[:services]
    end
    if roomtype_params[:restroom]
      @roomtype.restroom = roomtype_params[:restroom]
    end

    if roomtype_params[:basechildren] && roomtype_params[:baseadults]
      @roomtype.extrabed =  roomtype_params[:maximumguests].to_i - roomtype_params[:basechildren].to_i - roomtype_params[:baseadults].to_i
    end
    if roomtype_params[:typename]
      @roomtype.typename = roomtype_params[:typename]
    end
    if roomtype_params[:rooms]
      @roomtype.rooms = roomtype_params[:rooms]
    end
    if roomtype_params[:beds]
      @roomtype.beds = roomtype_params[:beds]
    end
    if roomtype_params[:baseadults]
      @roomtype.baseadults = roomtype_params[:baseadults]
    end
    if roomtype_params[:infants]
      @roomtype.infants = roomtype_params[:infants]
    end
    if roomtype_params[:basechildren]
      @roomtype.basechildren = roomtype_params[:basechildren]
    end
     if roomtype_params[:maximumguests]
      @roomtype.maximumguests = roomtype_params[:maximumguests]
    end
     if roomtype_params[:maximumadults]
      @roomtype.maximumadults = roomtype_params[:maximumadults]
    end
     if roomtype_params[:maximumchildren]
      @roomtype.maximumchildren = roomtype_params[:maximumchildren]
    end

    respond_to do |format|
      if @roomtype.save
       
        format.html { redirect_to '/roomtypes/'+@roomtype.id.to_s, notice: 'Room Type was successfully updated.' }
        format.json { render :show, status: :ok, location: @roomtype }
      else
        format.html { render :edit }
        format.json { render json: @roomtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roomtypes/1
  # DELETE /roomtypes/1.json
  
  
  def destroy
    @roomtype.destroy
    respond_to do |format|
      format.html { redirect_to roomtypes_url, notice: 'Roomtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roomtype
      if params[:id].to_i == 0
        return render file: "#{Rails.root}/public/500", status: :not_found
      end
      @roomtype = Roomtype.find(params[:id])
      rescue ActiveRecord::RecordNotFound  
        return render file: "#{Rails.root}/public/500", status: :not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roomtype_params
      # params.require(:roomtype).permit(:typename, :rooms, :beds, :baseadults, :maximumadults, :infants, :basechildren, :maximumchildren, :maximumguests,{basic: [:clothesracks,:dryingracking,:foldupbed,:sofabed,:wardrobe,:carpeted,:walkingcloset,:extralongbeds,:fireplace,:heater,:interconnectingrooms,:iron,:desk,:wifi,:smoking,:tv]},{restroom: [:bathroom,:toiletpaper,:bathtub,:shower,:bathrobe,:freetoiletries,:hairdryer,:spatub,:sharedbathroom,:slippers,:toilets,:geyser]},{services: [:executiveloungeaccess,:alarmclock,:wakeupservice,:linens,:sheets,:ac,:cooler,:fan,:kettle,:laundry]},{view: [:balcony,:terrace,:cityview,:lakeview,:landmarkview,:poolview,:riverview,:oceanview]},{images: []}, :hotel_id)
      params.require(:roomtype).permit(:typename, :rooms, :beds, :baseadults, :maximumadults, :infants, :basechildren, :maximumchildren, :maximumguests,{basic: [:clothesracks,:dryingracking,:foldupbed,:sofabed,:wardrobe,:carpeted,:walkingcloset,:extralongbeds,:fireplace,:heater,:interconnectingrooms,:iron,:desk,:wifi,:smoking,:tv]},{restroom: [:bathroom,:toiletpaper,:bathtub,:shower,:bathrobe,:freetoiletries,:hairdryer,:spatub,:sharedbathroom,:slippers,:toilets,:geyser]},{services: [:executiveloungeaccess,:alarmclock,:wakeupservice,:linens,:sheets,:ac,:cooler,:fan,:kettle,:laundry]},{view: [:balcony,:terrace,:cityview,:lakeview,:landmarkview,:poolview,:riverview,:oceanview]},{images: []}, :hotel_id)
    end
end

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

    @roomtype = Roomtype.new(roomtype_params)
    if roomtype_params[:basechildren] && roomtype_params[:baseadults]
      @roomtype.extrabed =  roomtype_params[:maximumguests].to_i - roomtype_params[:basechildren].to_i - roomtype_params[:baseadults].to_i
    end
    
    
    respond_to do |format|
      if @roomtype.update(roomtype_params)
        format.html { redirect_to '/room_papa/index', notice: 'Room Type was successfully updated.' }
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
      @roomtype = Roomtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roomtype_params
      params.require(:roomtype).permit(:typename, :rooms, :beds, :baseadults, :maximumadults, :infants, :basechildren, :maximumchildren, :maximumguests,{basic: [:clothesracks,:dryingracking,:foldupbed,:sofabed,:wardrobe,:carpeted,:walkingcloset,:extralongbeds,:fireplace,:heater,:interconnectingrooms,:iron,:desk,:wifi,:smoking,:tv]},{restroom: [:bathroom,:toiletpaper,:bathtub,:shower,:bathrobe,:freetoiletries,:hairdryer,:spatub,:sharedbathroom,:slippers,:toilets,:geyser]},{services: [:executiveloungeaccess,:alarmclock,:wakeupservice,:linens,:sheets,:ac,:cooler,:fan,:kettle,:laundry]},{view: [:balcony,:terrace,:cityview,:lakeview,:landmarkview,:poolview,:riverview,:oceanview]}, :hotel_id)
    end
end

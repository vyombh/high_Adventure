class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.all
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user_id = current_user.id
    respond_to do |format|
      if @hotel.save
        format.html { redirect_to '/room_papa/index',notice: 'Step #1 has been completed' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to '/room_papa/index', notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      # params.require(:hotel).permit(:hotelname, :hoteltype, :chainname, :floor, :currency, :rating, :year, :checkinhrsfrom, :checkinminfrom, :checkinampmfrom, :checkinhrsto, :checkinminto, :checkinampmto, :checkouthrsfrom, :checkoutminfrom, :checkoutampmfrom, :checkouthrsto, :checkoutminto, :checkoutampmto, :city, :streetname, :buildingname,:state,:country,:zipcode, :parking, :gym, :spa, :pool, :bar, :restaurant, :lift, :user_id)
      params.require(:hotel).permit(:hotelname, :hoteltype, :chainname, :floor, :currency, :rating, :year, :checkinhrsfrom, :checkinminfrom, :checkinampmfrom, :checkinhrsto, :checkinminto, :checkinampmto, :checkouthrsfrom, :checkoutminfrom, :checkoutampmfrom, :checkouthrsto, :checkoutminto, :checkoutampmto, :city, :streetname, :buildingname,:state,:country,:zipcode,:description, {basic: [:parking,:gym,:spa,:pool,:bar,:restaurant,:lift]},{media: [:computer,:gameconsole,:gameconsolenintendrowii,:gameconsoleps2,:gameconsoleps3,:gameconsoleps4,:gameconsolexbox360,:laptop,:ipad,:cablechannels,:cdplayer,:dvdplayer,:fax,:laptopsafe,:flatscreentv,:paypervideochannels,:radio,:satellitechannels,:telephone,:tv,:video,:videogames,:blurayplayer]},{food: [:diningarea,:diningtable,:barbecue,:stovetop,:toaster,:outdoordiningarea,:outdoorfurniture,:kitchenette,:kitchenware,:microwave,:refrigerator,:teacoffeemachine,:coffeemachine,:highchair]},{disability: [:groundfloor,:wheelchair,:elevator,:staircaseonly,:grabrailstoilet]},{entertainment: [:babysafetygases,:boardgamespuzzles,:books,:safetysockets]},:policies , :user_id)
    
    end
end



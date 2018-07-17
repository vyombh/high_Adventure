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
      if @hotel.errors.full_messages.length == 0&&@hotel.save
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
    if hotel_params[:images]
      @hotel.images = @hotel.images + hotel_params[:images]
    end
    if hotel_params[:basic]
      @hotel.basic = hotel_params[:basic]
    end
    if hotel_params[:media]
      @hotel.media = hotel_params[:media]
    end
    if hotel_params[:entertainment]
      @hotel.entertainment = hotel_params[:entertainment]
    end
    if hotel_params[:food]
      @hotel.food = hotel_params[:food]
    end
    if hotel_params[:disability]
      @hotel.disability = hotel_params[:disability]
    end
    if hotel_params[:checkinhrsfrom]
      @hotel.checkinhrsfrom = hotel_params[:checkinhrsfrom]
    end
    if hotel_params[:checkinminfrom]
      @hotel.checkinminfrom = hotel_params[:checkinminfrom]
    end
    if hotel_params[:checkinampmfrom]
      @hotel.checkinampmfrom = hotel_params[:checkinampmfrom]
    end
    if hotel_params[:checkinhrsto]
      @hotel.checkinhrsto = hotel_params[:checkinhrsto]
    end
    if hotel_params[:checkinminto]
      @hotel.checkinminto = hotel_params[:checkinminto]
    end
    if hotel_params[:checkinampmto]
      @hotel.checkinampmto = hotel_params[:checkinampmto]
    end
    if hotel_params[:checkouthrsfrom]
      @hotel.checkouthrsfrom = hotel_params[:checkouthrsfrom]
    end
    if hotel_params[:checkoutminfrom]
      @hotel.checkoutminfrom = hotel_params[:checkoutminfrom]
    end
    if hotel_params[:checkoutampmfrom]
      @hotel.checkoutampmfrom = hotel_params[:checkoutampmfrom]
    end
    if hotel_params[:checkouthrsto]
      @hotel.checkouthrsto = hotel_params[:checkouthrsto]
    end
    if hotel_params[:checkoutminto]
      @hotel.checkoutminto = hotel_params[:checkoutminto]
    end
    if hotel_params[:checkoutampmto]
      @hotel.checkoutampmto = hotel_params[:checkoutampmto]
    end
    if hotel_params[:description]
      @hotel.description = hotel_params[:description]
    end
    if hotel_params[:policies]
      @hotel.policies = hotel_params[:policies]
    end
    if hotel_params[:accholder]
      @hotel.accholder = hotel_params[:accholder]
    end
    if hotel_params[:accno]
      @hotel.accno = hotel_params[:accno]
    end
    if hotel_params[:gstno]
      @hotel.gstno = hotel_params[:gstno]
    end
    if hotel_params[:panno]
      @hotel.panno = hotel_params[:panno]
    end
    if hotel_params[:landmark]
      @hotel.landmark = hotel_params[:landmark]
    end
    if hotel_params[:phnno1]
      @hotel.phnno1 = hotel_params[:phnno1]
    end
    if hotel_params[:phnno2]
      @hotel.phnno2 = hotel_params[:phnno2]
    end
    if hotel_params[:landline]
      @hotel.landline = hotel_params[:landline]
    end
    if hotel_params[:email]
      @hotel.email = hotel_params[:email]
    end
    if hotel_params[:ifsccode]
      @hotel.ifsccode = hotel_params[:ifsccode]
    end
    respond_to do |format|
      if @hotel.save

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
  def deleteimage
    byebug
    hotel = Hotel.find_by_id(params[:hotel])
    count = 0
    @file = params[:file]
    hotel.images.each do |image|
      if image.file.path.split("/").last == params[:file]
        break;
      end
      count = count + 1
    end
    remain_images = hotel.images # copy initial avatars
    delete_image = remain_images.delete_at(count) # delete the target image
    delete_image.try(:remove!) # delete image
    hotel.images = remain_images # re-assign back
    hotel.save
    respond_to do |format|
      format.html { redirect_to '/hotels/'+hotel.id.to_s+'/edit' }
      format.js {}
    end
  end
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
      # params.require(:hotel).permit(:hotelname, :hoteltype, :chainname, :floor, :currency, :rating, :year, :checkinhrsfrom, :checkinminfrom, :checkinampmfrom, :checkinhrsto, :checkinminto, :checkinampmto, :checkouthrsfrom, :checkoutminfrom, :checkoutampmfrom, :checkouthrsto, :checkoutminto, :checkoutampmto, :city, :streetname, :buildingname,:state,:country,:zipcode,:description, {basic: [:parking,:gym,:spa,:pool,:bar,:restaurant,:lift]},{media: [:computer,:gameconsole,:gameconsolenintendowii,:gameconsoleps2,:gameconsoleps3,:gameconsoleps4,:gameconsolexbox360,:laptop,:ipad,:cablechannels,:cdplayer,:dvdplayer,:fax,:laptopsafe,:flatscreentv,:paypervideochannels,:radio,:satellitechannels,:telephone,:tv,:video,:videogames,:blurayplayer]},{food: [:diningarea,:diningtable,:barbecue,:stovetop,:toaster,:outdoordiningarea,:outdoorfurniture,:kitchenette,:kitchenware,:microwave,:refrigerator,:teacoffeemachine,:coffeemachine,:highchair]},{disability: [:groundfloor,:wheelchair,:elevator,:staircaseonly,:grabrailstoilet]},{entertainment: [:babysafetyglasses,:boardgamespuzzles,:books,:safetysockets]},:policies , :user_id)
      params.require(:hotel).permit(:hotelname, :hoteltype, :chainname, :floor, :currency, :rating, :year, :checkinhrsfrom, :checkinminfrom, :checkinampmfrom, :checkinhrsto, :checkinminto, :checkinampmto, :checkouthrsfrom, :checkoutminfrom, :checkoutampmfrom, :checkouthrsto, :checkoutminto, :checkoutampmto, :city, :streetname,:landmark, :buildingname,:state,:country,:zipcode,:phnno1, :phnno2, :landline, :email, {basic: [:bar,:gym,:lift,:parking,:restaurant,:spa,:swimmingpool]},{media: [:blurayplayer,:cablechannels,:cdplayer,:computer,:dvdplayer,:fax,:flatscreentv,:gameconsole,:ipad,:laptop,:laptopsafe,:nintendowii,:paypervideochannels,:ps2,:ps3,:ps4,:radio,:satellitechannels,:telephone,:tv,:video,:videogames,:xbox360]},{food: [:barbecue,:coffeemachine,:diningarea,:diningtable,:highchair,:kitchenette,:kitchenware,:microwave,:outdoordiningarea,:outdoorfurniture,:refrigerator,:stovetop,:teacoffeemachine,:toaster]},{disability: [:elevator,:grabrailstoilet,:groundfloor,:staircaseonly,:wheelchair]},{entertainment: [:babysafetyglasses,:boardgamespuzzles,:books,:safetysockets]},:description,:policies,:accholder,:accno,:ifsccode,:gstno,:panno,{images: []} , :user_id)
    end
end



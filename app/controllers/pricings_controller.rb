class PricingsController < ApplicationController
  before_action :set_pricing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /pricings
  # GET /pricings.json
  def index
    @pricings = Pricing.all
  end

  # GET /pricings/1
  # GET /pricings/1.json
  def show
  end

  # GET /pricings/new
  def new
    @id = nil
    @pricing = Pricing.new
  end

  # GET /pricings/1/edit
  def edit
  end

  # POST /pricings
  # POST /pricings.json
  def create
    @pricing = Pricing.new(pricing_params)
    @id = params[:id]
    respond_to do |format|
      if @pricing.save
        format.html { redirect_to '/roomtypes', notice: 'Pricing was successfully created.' }
        format.json { render :show, status: :created, location: @pricing }
      else
        format.html { render :new }
        format.json { render json: @pricing.errors, status: :unprocessable_entity }
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

  # DELETE /pricings/1
  # DELETE /pricings/1.json
  def destroy
    @pricing.destroy
    respond_to do |format|
      format.html { redirect_to pricings_url, notice: 'Pricing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pricing
      @pricing = Pricing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pricing_params
      params.require(:pricing).permit(:baseprice, :lunch, :dinner, :breakfast, :roomtype_id,:scheme)
    end
end

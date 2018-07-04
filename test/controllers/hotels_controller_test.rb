require 'test_helper'

class HotelsControllerTest < ActionController::TestCase
  setup do
    @hotel = hotels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hotels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hotel" do
    assert_difference('Hotel.count') do
      post :create, hotel: { bar: @hotel.bar, buildingname: @hotel.buildingname, chainname: @hotel.chainname, checkinampmfrom: @hotel.checkinampmfrom, checkinampmto: @hotel.checkinampmto, checkinhrsfrom: @hotel.checkinhrsfrom, checkinhrsto: @hotel.checkinhrsto, checkinminfrom: @hotel.checkinminfrom, checkinminto: @hotel.checkinminto, checkoutampmfrom: @hotel.checkoutampmfrom, checkoutampmto: @hotel.checkoutampmto, checkouthrsfrom: @hotel.checkouthrsfrom, checkouthrsto: @hotel.checkouthrsto, checkoutminfrom: @hotel.checkoutminfrom, checkoutminto: @hotel.checkoutminto, currency: @hotel.currency, floor: @hotel.floor, gym: @hotel.gym, hotelname: @hotel.hotelname, hoteltype: @hotel.hoteltype, lift: @hotel.lift, parking: @hotel.parking, pool: @hotel.pool, rating: @hotel.rating, restaurant: @hotel.restaurant, spa: @hotel.spa, streetname: @hotel.streetname, user_id: @hotel.user_id, year: @hotel.year }
    end

    assert_redirected_to hotel_path(assigns(:hotel))
  end

  test "should show hotel" do
    get :show, id: @hotel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hotel
    assert_response :success
  end

  test "should update hotel" do
    patch :update, id: @hotel, hotel: { bar: @hotel.bar, buildingname: @hotel.buildingname, chainname: @hotel.chainname, checkinampmfrom: @hotel.checkinampmfrom, checkinampmto: @hotel.checkinampmto, checkinhrsfrom: @hotel.checkinhrsfrom, checkinhrsto: @hotel.checkinhrsto, checkinminfrom: @hotel.checkinminfrom, checkinminto: @hotel.checkinminto, checkoutampmfrom: @hotel.checkoutampmfrom, checkoutampmto: @hotel.checkoutampmto, checkouthrsfrom: @hotel.checkouthrsfrom, checkouthrsto: @hotel.checkouthrsto, checkoutminfrom: @hotel.checkoutminfrom, checkoutminto: @hotel.checkoutminto, currency: @hotel.currency, floor: @hotel.floor, gym: @hotel.gym, hotelname: @hotel.hotelname, hoteltype: @hotel.hoteltype, lift: @hotel.lift, parking: @hotel.parking, pool: @hotel.pool, rating: @hotel.rating, restaurant: @hotel.restaurant, spa: @hotel.spa, streetname: @hotel.streetname, user_id: @hotel.user_id, year: @hotel.year }
    assert_redirected_to hotel_path(assigns(:hotel))
  end

  test "should destroy hotel" do
    assert_difference('Hotel.count', -1) do
      delete :destroy, id: @hotel
    end

    assert_redirected_to hotels_path
  end
end

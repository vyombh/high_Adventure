require 'rails_helper'

RSpec.describe BookingsController, type: :controller do

  describe "GET #order" do
    it "returns http success" do
      get :order
      expect(response).to have_http_status(:success)
    end
  end

end

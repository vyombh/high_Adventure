require 'rails_helper'

RSpec.describe "Pricings", type: :request do
  describe "GET /pricings" do
    it "works! (now write some real specs)" do
      get pricings_path
      expect(response).to have_http_status(200)
    end
  end
end

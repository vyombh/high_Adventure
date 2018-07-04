require "rails_helper"

RSpec.describe PricingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pricings").to route_to("pricings#index")
    end

    it "routes to #new" do
      expect(:get => "/pricings/new").to route_to("pricings#new")
    end

    it "routes to #show" do
      expect(:get => "/pricings/1").to route_to("pricings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pricings/1/edit").to route_to("pricings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pricings").to route_to("pricings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pricings/1").to route_to("pricings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pricings/1").to route_to("pricings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pricings/1").to route_to("pricings#destroy", :id => "1")
    end

  end
end

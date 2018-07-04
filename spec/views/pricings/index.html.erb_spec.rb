require 'rails_helper'

RSpec.describe "pricings/index", type: :view do
  before(:each) do
    assign(:pricings, [
      Pricing.create!(
        :baseprice => 2.5,
        :lunch => 3.5,
        :dinner => 4.5,
        :breakfast => 5.5,
        :roomtype => nil
      ),
      Pricing.create!(
        :baseprice => 2.5,
        :lunch => 3.5,
        :dinner => 4.5,
        :breakfast => 5.5,
        :roomtype => nil
      )
    ])
  end

  it "renders a list of pricings" do
    render
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

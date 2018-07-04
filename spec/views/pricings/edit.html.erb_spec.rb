require 'rails_helper'

RSpec.describe "pricings/edit", type: :view do
  before(:each) do
    @pricing = assign(:pricing, Pricing.create!(
      :baseprice => 1.5,
      :lunch => 1.5,
      :dinner => 1.5,
      :breakfast => 1.5,
      :roomtype => nil
    ))
  end

  it "renders the edit pricing form" do
    render

    assert_select "form[action=?][method=?]", pricing_path(@pricing), "post" do

      assert_select "input#pricing_baseprice[name=?]", "pricing[baseprice]"

      assert_select "input#pricing_lunch[name=?]", "pricing[lunch]"

      assert_select "input#pricing_dinner[name=?]", "pricing[dinner]"

      assert_select "input#pricing_breakfast[name=?]", "pricing[breakfast]"

      assert_select "input#pricing_roomtype_id[name=?]", "pricing[roomtype_id]"
    end
  end
end

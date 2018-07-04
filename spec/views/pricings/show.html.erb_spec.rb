require 'rails_helper'

RSpec.describe "pricings/show", type: :view do
  before(:each) do
    @pricing = assign(:pricing, Pricing.create!(
      :baseprice => 2.5,
      :lunch => 3.5,
      :dinner => 4.5,
      :breakfast => 5.5,
      :roomtype => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(//)
  end
end

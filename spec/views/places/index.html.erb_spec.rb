require 'rails_helper'

RSpec.describe "places/index", type: :view do
  before(:each) do
    assign(:places, [
      Place.create!(
        :name => "MyText",
        :latitude => 2.5,
        :longitude => 3.5,
        :user => nil
      ),
      Place.create!(
        :name => "MyText",
        :latitude => 2.5,
        :longitude => 3.5,
        :user => nil
      )
    ])
  end

  it "renders a list of places" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

require 'rails_helper'

RSpec.describe "places/new", type: :view do
  before(:each) do
    assign(:place, Place.new(
      :name => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :user => nil
    ))
  end

  it "renders new place form" do
    render

    assert_select "form[action=?][method=?]", places_path, "post" do

      assert_select "textarea#place_name[name=?]", "place[name]"

      assert_select "input#place_latitude[name=?]", "place[latitude]"

      assert_select "input#place_longitude[name=?]", "place[longitude]"

      assert_select "input#place_user_id[name=?]", "place[user_id]"
    end
  end
end

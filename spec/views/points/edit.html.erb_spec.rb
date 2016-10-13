require 'rails_helper'

RSpec.describe "points/edit", type: :view do
  before(:each) do
    @point = assign(:point, Point.create!(
      :user => nil,
      :description => "MyText",
      :place => nil
    ))
  end

  it "renders the edit point form" do
    render

    assert_select "form[action=?][method=?]", point_path(@point), "post" do

      assert_select "input#point_user_id[name=?]", "point[user_id]"

      assert_select "textarea#point_description[name=?]", "point[description]"

      assert_select "input#point_place_id[name=?]", "point[place_id]"
    end
  end
end

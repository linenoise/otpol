require 'rails_helper'

RSpec.describe "points/new", type: :view do
  before(:each) do
    assign(:point, Point.new(
      :user => nil,
      :description => "MyText"
    ))
  end

  it "renders new point form" do
    render

    assert_select "form[action=?][method=?]", points_path, "post" do

      assert_select "input#point_user_id[name=?]", "point[user_id]"

      assert_select "textarea#point_description[name=?]", "point[description]"
    end
  end
end

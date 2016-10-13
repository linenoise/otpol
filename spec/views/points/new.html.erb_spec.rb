require 'rails_helper'

RSpec.describe "moments/new", type: :view do
  before(:each) do
    assign(:moment, Moment.new(
      :user => nil,
      :description => "MyText",
      :place => nil
    ))
  end

  it "renders new moment form" do
    render

    assert_select "form[action=?][method=?]", moments_path, "post" do

      assert_select "input#moment_user_id[name=?]", "moment[user_id]"

      assert_select "textarea#moment_description[name=?]", "moment[description]"

      assert_select "input#moment_place_id[name=?]", "moment[place_id]"
    end
  end
end

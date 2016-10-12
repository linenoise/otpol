require 'rails_helper'

RSpec.describe "moments/edit", type: :view do
  before(:each) do
    @moment = assign(:moment, Moment.create!(
      :user => nil,
      :description => "MyText",
      :place => nil
    ))
  end

  it "renders the edit moment form" do
    render

    assert_select "form[action=?][method=?]", moment_path(@moment), "post" do

      assert_select "input#moment_user_id[name=?]", "moment[user_id]"

      assert_select "textarea#moment_description[name=?]", "moment[description]"

      assert_select "input#moment_place_id[name=?]", "moment[place_id]"
    end
  end
end

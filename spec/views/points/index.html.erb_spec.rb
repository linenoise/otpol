require 'rails_helper'

RSpec.describe "moments/index", type: :view do
  before(:each) do
    assign(:moments, [
      Moment.create!(
        :user => nil,
        :description => "MyText",
        :place => nil
      ),
      Moment.create!(
        :user => nil,
        :description => "MyText",
        :place => nil
      )
    ])
  end

  it "renders a list of moments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

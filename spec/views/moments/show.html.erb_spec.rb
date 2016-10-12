require 'rails_helper'

RSpec.describe "moments/show", type: :view do
  before(:each) do
    @moment = assign(:moment, Moment.create!(
      :user => nil,
      :description => "MyText",
      :place => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end

require 'rails_helper'

RSpec.describe "Moments", type: :request do
  describe "GET /moments" do
    it "works! (now write some real specs)" do
      get moments_path
      expect(response).to have_http_status(200)
    end
  end
end

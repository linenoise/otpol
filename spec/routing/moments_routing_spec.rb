require "rails_helper"

RSpec.describe MomentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/moments").to route_to("moments#index")
    end

    it "routes to #new" do
      expect(:get => "/moments/new").to route_to("moments#new")
    end

    it "routes to #show" do
      expect(:get => "/moments/1").to route_to("moments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/moments/1/edit").to route_to("moments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/moments").to route_to("moments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/moments/1").to route_to("moments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/moments/1").to route_to("moments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/moments/1").to route_to("moments#destroy", :id => "1")
    end

  end
end

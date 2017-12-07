# frozen_string_literal: true

require "rails_helper"

RSpec.describe GatekeepersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/gatekeepers").to route_to("gatekeepers#index")
    end

    it "routes to #new" do
      expect(get: "/gatekeepers/new").to route_to("gatekeepers#new")
    end

    it "routes to #show" do
      expect(get: "/gatekeepers/1").to route_to("gatekeepers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/gatekeepers/1/edit").to route_to("gatekeepers#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/gatekeepers").to route_to("gatekeepers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/gatekeepers/1").to route_to("gatekeepers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/gatekeepers/1").to route_to("gatekeepers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/gatekeepers/1").to route_to("gatekeepers#destroy", id: "1")
    end

  end
end

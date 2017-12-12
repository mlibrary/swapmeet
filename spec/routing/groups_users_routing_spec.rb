# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #join via PATCH" do
      expect(patch: "/groups/1/users/2/join").to route_to("users#join", group_id: "1", id: "2")
    end

    it "routes to #leave via DELETE" do
      expect(delete: "/groups/1/users/2/leave").to route_to("users#leave", group_id: "1", id: "2")
    end

  end
end

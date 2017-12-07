# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Gatekeepers", type: :request do
  describe "GET /gatekeepers" do
    it "works! (now write some real specs)" do
      get gatekeepers_path
      expect(response).to have_http_status(401) # unauthorized
    end
  end
end

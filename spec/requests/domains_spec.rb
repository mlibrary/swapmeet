# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Domains", type: :request do
  describe "GET /domains" do
    it "works! (now write some real specs)" do
      get domains_path
      expect(response).to have_http_status(401) # unauthorized
    end
  end
end

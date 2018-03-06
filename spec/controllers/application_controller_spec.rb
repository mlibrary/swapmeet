# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  context 'rescue_from exception' do
    controller do
      attr_accessor :the_exception
      def trigger
        raise @the_exception
      end
    end
    before do
      routes.draw { get "trigger" => "anonymous#trigger" }
    end
    it "responds with unauthorized on NotAuthorizedError" do
      controller.the_exception = NotAuthorizedError.new
      expect { get :trigger }.not_to raise_error
      expect(response).to be_unauthorized
    end
  end

  context 'user identity' do

    INST_ID = 1
    NETWORK = "10.0.0.0/16"

    before(:all) do
      range = IPAddr.new(NETWORK).to_range
    end

    controller do
      def something
        request.set_header('X-Forwarded-For',"10.0.0.1")
        render body: nil
      end

      def identity
        current_user.identity
      end
    end

    before do
      range = IPAddr.new(NETWORK).to_range
      Keycard::DB[:aa_network].insert([1, nil, NETWORK, range.first.to_i, range.last.to_i,
                                       'allow', nil, INST_ID, Time.now.utc, 'test', 'f'])
      routes.draw { get "something" => "anonymous#something" }
    end

    after do
      Keycard::DB[:aa_network].delete
    end

    it "adds institutional identity when constructing the current_user" do
      get :something

      expect(controller.identity["dlpsInstitutionIds"]).to contain_exactly(INST_ID)
    end

    it "adds identity when constructing the current_user" do
      get :something

      expect(controller.identity).not_to be_nil
    end

  end
end

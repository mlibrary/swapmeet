# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
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

    # because testing rails controllers is messy, ApplicationController even
    # more so
    controller do
      def something
        render body: nil
      end

      def identity
        current_user.identity
      end
    end

    before do
      routes.draw { get "something" => "anonymous#something" }
    end

    it "adds identity hash constructing the current_user" do
      get :something

      expect(controller.identity).to be_a Hash
    end

  end
end

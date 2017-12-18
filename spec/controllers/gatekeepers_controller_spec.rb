# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GatekeepersController, type: :controller do
  it_should_behave_like 'policy enforcer', :gatekeeper, :Gatekeeper
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainsController, type: :controller do
  it_should_behave_like 'policy enforcer', :domain, :Domain
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublishersController, type: :controller do
  it_should_behave_like 'policy enforcer', :publisher, :Publisher
end

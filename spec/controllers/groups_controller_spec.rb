# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  it_should_behave_like 'policy enforcer', :group, :Group
end

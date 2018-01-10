# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  describe 'application policy' do
    subject { described_class.new(nil, nil).any_action? }
    it { is_expected.to be false }
  end
end

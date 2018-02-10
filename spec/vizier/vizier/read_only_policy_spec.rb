# frozen_string_literal: true

require 'vizier/read_only_policy'

RSpec.describe Vizier::ReadOnlyPolicy do

  subject(:policy) { described_class.new(double('User'), double('Resource')) }

  it 'allows show?' do
    expect(policy.show?).to be true
  end

  it 'does not raise on authorize! :show?' do
    expect { policy.authorize! :show? }.not_to raise_exception
  end
end

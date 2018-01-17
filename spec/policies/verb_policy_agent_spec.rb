# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VerbPolicyAgent do
  subject { described_class.new(nil, nil) }
  it { is_expected.to be_a(PolicyAgent) }
end

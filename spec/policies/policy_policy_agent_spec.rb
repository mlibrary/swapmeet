# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyPolicyAgent do
  subject { described_class.new(policy) }

  let(:policy) { double('policy') }

  it { is_expected.to be_a(VerbPolicyAgent) }
  it { expect(subject.client_type).to eq :Policy.to_s }
  it { expect(subject.client_id).to eq policy.to_s }
  it { expect(subject.client).to be policy }
end

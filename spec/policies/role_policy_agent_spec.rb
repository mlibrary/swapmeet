# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RolePolicyAgent do
  subject { described_class.new(role) }

  let(:role) { double('role') }

  it { is_expected.to be_a(VerbPolicyAgent) }
  it { expect(subject.client_type).to eq :Role.to_s }
  it { expect(subject.client_id).to eq role.to_s }
  it { expect(subject.client).to be role }
end

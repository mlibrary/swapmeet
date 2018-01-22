# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupPolicyAgent do
  subject { group_agent }

  let(:group_agent) { described_class.new(group) }
  let(:group) { double('group') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :Group.to_s }
  it { expect(subject.client_id).to eq group.to_s }
  it { expect(subject.client).to be group }
end

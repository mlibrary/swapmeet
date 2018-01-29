# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrivilegePolicyAgent do
  subject { privilege_agent }

  let(:privilege_agent) { described_class.new(privilege) }
  let(:privilege) { double('privilege') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :Privilege.to_s }
  it { expect(subject.client_id).to eq privilege.to_s }
  it { expect(subject.client).to be privilege }
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainPolicyAgent do
  subject { domain_agent }

  let(:domain_agent) { described_class.new(domain) }
  let(:domain) { double('domain') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :Domain.to_s }
  it { expect(subject.client_id).to eq domain.to_s }
  it { expect(subject.client).to be domain }
end

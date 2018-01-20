# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ObjectPolicyAgent do
  subject { object_agent }

  let(:object_agent) { described_class.new(:Entity, entity) }
  let(:entity) { double('entity') }

  it { is_expected.to be_a(NounPolicyAgent) }
  it { expect(subject.client_type).to eq :Entity.to_s }
  it { expect(subject.client_id).to eq entity.to_s }
  it { expect(subject.client).to be entity }
end

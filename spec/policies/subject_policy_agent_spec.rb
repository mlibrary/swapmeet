# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubjectPolicyAgent do
  subject { entity_agent }

  let(:entity_agent) { described_class.new(:Entity, entity) }
  let(:entity) { double('entity') }

  it { is_expected.to be_a(PolicyAgent) }
  it { expect(subject.client_type).to eq :Entity.to_s }
  it { expect(subject.client_id).to eq entity.to_s }
  it { expect(subject.client).to be entity }

  describe '#administrator?' do
    subject { entity_agent.administrator? }

    it { is_expected.to be false }

    context 'administrator' do
      let(:role) { RolePolicyAgent.new(:administrator) }

      before do
        Gatekeeper.new(
          subject_type: entity_agent.client_type,
          subject_id: entity_agent.client_id,
          verb_type: role.client_type,
          verb_id: role.client_id,
          object_type: PolicyMaker::OBJECT_ANY.client_type,
          object_id: PolicyMaker::OBJECT_ANY.client_id
        ).save!
      end

      it { is_expected.to be true }
    end
  end
end

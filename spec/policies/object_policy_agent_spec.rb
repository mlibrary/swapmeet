# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ObjectPolicyAgent do
  subject { object_agent }

  let(:object_agent) { described_class.new(:Entity, entity) }
  let(:entity) { double('entity') }

  it { is_expected.to be_a(PolicyAgent) }
  it { expect(subject.client_type).to eq :Entity.to_s }
  it { expect(subject.client_id).to eq entity.to_s }
  it { expect(subject.client).to be entity }

  describe '#administrator?' do
    subject { object_agent.administrator?(user) }

    let(:user) { double('user') }

    it { is_expected.to be false }

    context 'administrator' do
      let(:user_agent) { UserPolicyAgent.new(user) }
      let(:role) { RolePolicyAgent.new(:administrator) }

      before do
        Gatekeeper.new(
          subject_type: user_agent.client_type,
          subject_id: user_agent.client_id,
          verb_type: role.client_type,
          verb_id: role.client_id,
          object_type: object_agent.client_type,
          object_id: object_agent.client_id
        ).save!
      end

      it { is_expected.to be true }
    end
  end
end

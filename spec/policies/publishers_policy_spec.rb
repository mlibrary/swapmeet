# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublishersPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  describe 'publishers policy' do
    subject { described_class.new(user_agent, object_agent) }

    let(:user_agent) { UserPolicyAgent.new(user) }
    let(:user) { double('user') }
    let(:object_agent) { ObjectPolicyAgent.new(:Publisher, publisher) }
    let(:publisher) { double('publisher') }

    before do
      allow(user_agent).to receive(:authenticated?).and_return(true)
    end

    context 'without permission' do
      it do
        expect(subject.index?).to be true
        expect(subject.show?).to be true
        expect(subject.create?).to be false
        expect(subject.update?).to be false
        expect(subject.destroy?).to be false
        expect(subject.add?).to be false
        expect(subject.remove?).to be false
      end
    end

    context 'with permission' do
      let(:requestor_agent) { RequestorPolicyAgent.new(:Requestor, :requestor) }
      before do
        Gatekeeper.new(
          subject_type: requestor_agent.client_type,
          subject_id: requestor_agent.client_id,
          verb_type: PolicyMaker::POLICY_ANY.client_type,
          verb_id: PolicyMaker::POLICY_ANY.client_id,
          object_type: object_agent.client_type,
          object_id: object_agent.client_id
        ).save!
        policy_maker = PolicyMaker.new(requestor_agent)
        policy_maker.permit!(user_agent, ActionPolicyAgent.new(:index), object_agent)
        policy_maker.permit!(user_agent, ActionPolicyAgent.new(:show), object_agent)
        policy_maker.permit!(user_agent, ActionPolicyAgent.new(:create), object_agent)
        policy_maker.permit!(user_agent, ActionPolicyAgent.new(:update), object_agent)
        policy_maker.permit!(user_agent, ActionPolicyAgent.new(:destroy), object_agent)
        policy_maker.permit!(user_agent, ActionPolicyAgent.new(:add), object_agent)
        policy_maker.permit!(user_agent, ActionPolicyAgent.new(:remove), object_agent)
      end
      it do
        expect(subject.index?).to be true
        expect(subject.show?).to be true
        expect(subject.create?).to be true
        expect(subject.update?).to be true
        expect(subject.destroy?).to be true
        expect(subject.add?).to be true
        expect(subject.remove?).to be true
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  let(:user_agent) { UserPolicyAgent.new(user) }
  let(:user) { double('user') }

  context 'Entity' do
    subject { described_class.new(entity_agent, user_agent) }

    let(:entity_agent) { SubjectPolicyAgent.new(:Entity, entity) }
    let(:entity) { double('entity') }

    it do
      expect(subject.index?).to be false
      expect(subject.show?).to be false
      expect(subject.create?).to be false
      expect(subject.update?).to be false
      expect(subject.destroy?).to be false
      expect(subject.join?).to be false
      expect(subject.leave?).to be false
    end

    # context 'Recursion' do
    #   let(:agent) { double('agent') }
    #   let(:policy) { double('policy') }
    #   let(:boolean) { double('boolean') }
    #
    #   before do
    #     allow(UserPolicyAgent).to receive(:new).with(user).and_call_original
    #     allow(UserPolicyAgent).to receive(:new).with(entity).and_return(agent)
    #     allow(UsersPolicy).to receive(:new).with(entity_agent, user_agent).and_call_original
    #     allow(UsersPolicy).to receive(:new).with(entity_agent, agent).and_return(policy)
    #   end
    #
    #   describe '#show_user?' do
    #     before { allow(policy).to receive(:show?).and_return(boolean) }
    #     it { expect(subject.show_user?(entity)).to eq boolean }
    #   end
    #
    #   describe '#edit_user?' do
    #     before { allow(policy).to receive(:edit?).and_return(boolean) }
    #     it { expect(subject.edit_user?(entity)).to eq boolean }
    #   end
    #
    #   describe '#destroy_user?' do
    #     before { allow(policy).to receive(:destroy?).and_return(boolean) }
    #     it { expect(subject.destroy_user?(entity)).to eq boolean }
    #   end
    #
    #   describe '#administrator_user?' do
    #     before { allow(agent).to receive(:administrator?).and_return(boolean) }
    #     it { expect(subject.administrator_user?(entity)).to eq boolean }
    #   end
    #
    #   describe '#permit_user?' do
    #     before do
    #       allow(PrivilegesPolicy).to receive(:new).with(entity_agent, agent).and_return(policy)
    #       allow(policy).to receive(:permit?).and_return(boolean)
    #     end
    #     it { expect(subject.permit_user?(entity)).to eq boolean }
    #   end
    #
    #   describe '#revoke_user?' do
    #     before do
    #       allow(PrivilegesPolicy).to receive(:new).with(entity_agent, agent).and_return(policy)
    #       allow(policy).to receive(:revoke?).and_return(boolean)
    #     end
    #     it { expect(subject.revoke_user?(entity)).to eq boolean }
    #   end
    # end
  end

  context 'User' do
    subject { described_class.new(current_user_agent, user_agent) }

    let(:current_user_agent) { UserPolicyAgent.new(current_user) }
    let(:current_user) { double('current user') }

    before do
      allow(current_user_agent).to receive(:authenticated?).and_return(false)
    end

    it do
      expect(subject.index?).to be true
      expect(subject.show?).to be false
      expect(subject.create?).to be false
      expect(subject.update?).to be false
      expect(subject.destroy?).to be false
      expect(subject.join?).to be false
      expect(subject.leave?).to be false
    end

    context 'Authenticated' do
      before do
        allow(current_user_agent).to receive(:authenticated?).and_return(true)
      end

      it do
        expect(subject.index?).to be true
        expect(subject.show?).to be true
        expect(subject.create?).to be false
        expect(subject.update?).to be false
        expect(subject.destroy?).to be false
        expect(subject.join?).to be false
        expect(subject.leave?).to be false
      end

      context 'Grant' do
        let(:requestor_agent) { RequestorPolicyAgent.new(:Requestor, requestor) }
        let(:requestor) { double('requestor') }

        before do
          # Allow requestor to create any subject, any verb, any object policies
          Gatekeeper.new(
            subject_type: requestor_agent.client_type,
            subject_id: requestor_agent.client_id,
            verb_type: PolicyMaker::AGENT_ANY.client_type,
            verb_id: PolicyMaker::AGENT_ANY.client_id,
            object_type: PolicyMaker::AGENT_ANY.client_type,
            object_id: PolicyMaker::AGENT_ANY.client_id
          ).save!
          policy_maker = PolicyMaker.new(requestor_agent)
          policy_maker.permit!(PolicyMaker::USER_ANY, PolicyMaker::ACTION_ANY, PolicyMaker::OBJECT_ANY)
        end

        it do
          expect(subject.index?).to be true
          expect(subject.show?).to be true
          expect(subject.create?).to be true
          expect(subject.update?).to be true
          expect(subject.destroy?).to be true
          expect(subject.join?).to be true
          expect(subject.leave?).to be true
        end
      end
    end
  end
end

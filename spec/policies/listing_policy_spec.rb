# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  let(:listing_agent) { ListingPolicyAgent.new(listing_client) }
  let(:listing_client) { double('listing  client') }

  context 'General Form' do
    subject { described_class.new(subject_agent, listing_agent) }

    let(:subject_agent) { SubjectPolicyAgent.new(:Subject, subject_client) }
    let(:subject_client) { double('subject client') }

    context 'Action' do
      it do
        expect(subject.index?).to be false
        expect(subject.show?).to be false
        expect(subject.create?).to be false
        expect(subject.update?).to be false
        expect(subject.destroy?).to be false
      end
    end

    context 'Recursion' do
      let(:entity) { double('entity') }
      let(:agent) { double('agent') }
      let(:policy) { double('policy') }
      let(:boolean) { double('boolean') }

      describe '#edit_listing?' do
        before do
          allow(ListingPolicyAgent).to receive(:new).with(listing_client).and_call_original
          allow(ListingPolicyAgent).to receive(:new).with(entity).and_return(agent)
          allow(ListingPolicy).to receive(:new).with(subject_agent, listing_agent).and_call_original
          allow(ListingPolicy).to receive(:new).with(subject_agent, agent).and_return(policy)
          allow(policy).to receive(:edit?).and_return(boolean)
        end
        it { expect(subject.edit_listing?(entity)).to eq boolean }
      end

      describe '#destroy_listing?' do
        before do
          allow(ListingPolicyAgent).to receive(:new).with(listing_client).and_call_original
          allow(ListingPolicyAgent).to receive(:new).with(entity).and_return(agent)
          allow(ListingPolicy).to receive(:new).with(subject_agent, listing_agent).and_call_original
          allow(ListingPolicy).to receive(:new).with(subject_agent, agent).and_return(policy)
          allow(policy).to receive(:destroy?).and_return(boolean)
        end
        it { expect(subject.destroy_listing?(entity)).to eq boolean }
      end
    end
  end

  context 'User' do
    subject { described_class.new(user_agent, listing_agent) }

    let(:user_agent) { UserPolicyAgent.new(user_client) }
    let(:user_client) { double('user client') }

    before do
      allow(user_agent).to receive(:authenticated?).and_return(false)
    end

    it do
      expect(subject.index?).to be true
      expect(subject.show?).to be true
      expect(subject.create?).to be false
      expect(subject.update?).to be false
      expect(subject.destroy?).to be false
    end

    context 'Authenticated' do
      before do
        allow(user_agent).to receive(:authenticated?).and_return(true)
        allow(listing_agent).to receive(:creator?).with(user_client).and_return(false)
      end

      it do
        expect(subject.index?).to be true
        expect(subject.show?).to be true
        expect(subject.create?).to be true
        expect(subject.update?).to be false
        expect(subject.destroy?).to be false
      end

      context 'Creator' do
        before do
          allow(listing_agent).to receive(:creator?).with(user_client).and_return(true)
        end

        it do
          expect(subject.index?).to be true
          expect(subject.show?).to be true
          expect(subject.create?).to be true
          expect(subject.update?).to be true
          expect(subject.destroy?).to be true
        end
      end

      context 'Grant' do
        let(:requestor_agent) { RequestorPolicyAgent.new(:Requestor, requestor_client) }
        let(:requestor_client) { double('requestor client') }

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
          policy_maker.permit!(PolicyMaker::USER_ANY, PolicyMaker::ACTION_ANY, PolicyMaker::LISTING_ANY)
        end

        it do
          expect(subject.index?).to be true
          expect(subject.show?).to be true
          expect(subject.create?).to be true
          expect(subject.update?).to be true
          expect(subject.destroy?).to be true
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyMaker do
  subject { policy_maker }

  let(:policy_maker) { described_class.new(requestor_agent) }
  let(:requestor_agent) { RequestorPolicyAgent.new(:User, user) }
  let(:user) { double('user') }
  let(:subject_agent) { SubjectPolicyAgent.new(:Subject, :subject) }
  let(:verb_agent) { VerbPolicyAgent.new(:Verb, :verb) }
  let(:object_agent) { ObjectPolicyAgent.new(:Object, :object) }

  context 'requestor' do
    context 'default is to deny' do
      it do
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
      end
    end

    context 'grant only #permit!' do
      before do
        Gatekeeper.new(
          subject_type: requestor_agent.client_type,
          subject_id: requestor_agent.client_id,
          verb_type: PolicyMaker::POLICY_PERMIT.client_type,
          verb_id: PolicyMaker::POLICY_PERMIT.client_id,
          object_type: object_agent.client_type,
          object_id: object_agent.client_id
        ).save!
      end

      it do
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
      end
    end

    context 'grant only #revoke!' do
      before do
        Gatekeeper.new(
          subject_type: requestor_agent.client_type,
          subject_id: requestor_agent.client_id,
          verb_type: PolicyMaker::POLICY_REVOKE.client_type,
          verb_id: PolicyMaker::POLICY_REVOKE.client_id,
          object_type: object_agent.client_type,
          object_id: object_agent.client_id
        ).save!
      end

      it do
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
      end
    end

    context 'grant both #permit! and #revoke!' do
      before do
        Gatekeeper.new(
          subject_type: requestor_agent.client_type,
          subject_id: requestor_agent.client_id,
          verb_type: PolicyMaker::POLICY_ANY.client_type,
          verb_id: PolicyMaker::POLICY_ANY.client_id,
          object_type: object_agent.client_type,
          object_id: object_agent.client_id
        ).save!
      end

      it do
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
      end
    end

    context 'administrator' do
      let(:user_agent) { double('user agent') }
      before do
        allow(UserPolicyAgent).to receive(:new).with(user).and_return(user_agent)
        allow(user_agent).to receive(:administrator?).and_return(true)
      end
      it do
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
      end
    end
  end

  context 'policy' do
    let(:policy_resolver) { PolicyResolver.new(subject_agent, verb_agent, object_agent) }

    context 'ignore multiple calls' do
      before do
        Gatekeeper.new(
          subject_type: requestor_agent.client_type,
          subject_id: requestor_agent.client_id,
          verb_type: PolicyMaker::POLICY_ANY.client_type,
          verb_id: PolicyMaker::POLICY_ANY.client_id,
          object_type: object_agent.client_type,
          object_id: object_agent.client_id
        ).save!
      end

      it do
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_resolver.grant?).to be false
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_resolver.grant?).to be true
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_resolver.grant?).to be true
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_resolver.grant?).to be false
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_resolver.grant?).to be false
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_resolver.grant?).to be true
        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_resolver.grant?).to be false
      end
    end

    context 'specific and general policies' do
      let(:object_agent_type) { ObjectPolicyAgent.new(:Object, nil) }
      let(:object_agent_any) { ObjectPolicyAgent.new(nil, nil) }

      before do
        Gatekeeper.new(
          subject_type: requestor_agent.client_type,
          subject_id: requestor_agent.client_id,
          verb_type: PolicyMaker::POLICY_ANY.client_type,
          verb_id: PolicyMaker::POLICY_ANY.client_id,
          object_type: object_agent_any.client_type,
          object_id: object_agent_any.client_id
        ).save!
      end

      it do
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_type)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_any)).to be false
        expect(policy_resolver.grant?).to be false

        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent)).to be true

        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_type)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_any)).to be false
        expect(policy_resolver.grant?).to be true

        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent_type)).to be true

        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_type)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_any)).to be false
        expect(policy_resolver.grant?).to be true

        expect(policy_maker.permit!(subject_agent, verb_agent, object_agent_any)).to be true

        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_type)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_any)).to be true
        expect(policy_resolver.grant?).to be true

        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent)).to be true

        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_type)).to be true
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_any)).to be true
        expect(policy_resolver.grant?).to be true


        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent_type)).to be true

        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_type)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_any)).to be true
        expect(policy_resolver.grant?).to be true

        expect(policy_maker.revoke!(subject_agent, verb_agent, object_agent_any)).to be true

        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_type)).to be false
        expect(policy_maker.exist?(subject_agent, verb_agent, object_agent_any)).to be false
        expect(policy_resolver.grant?).to be false
      end
    end
  end
end

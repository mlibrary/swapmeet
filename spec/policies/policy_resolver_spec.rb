# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyResolver do
  let(:policy_resolver) { described_class.new(subject_agent_id, verb_agent_id, object_agent_id) }

  let(:subject_agent_any) { SubjectPolicyAgent.new(nil, nil) }
  let(:subject_agent_type) { SubjectPolicyAgent.new(:Subject, nil) }
  let(:subject_agent_id) { SubjectPolicyAgent.new(:Subject, :subject) }
  let(:verb_agent_any) { VerbPolicyAgent.new(nil, nil) }
  let(:verb_agent_type) { VerbPolicyAgent.new(:Verb, nil) }
  let(:verb_agent_id) { VerbPolicyAgent.new(:Verb, :verb) }
  let(:object_agent_any) { ObjectPolicyAgent.new(nil, nil) }
  let(:object_agent_type) { ObjectPolicyAgent.new(:Object, nil) }
  let(:object_agent_id) { ObjectPolicyAgent.new(::Object, :object) }

  describe '#grant?' do
    subject { policy_resolver.grant? }

    context 'no policy (empty table) no access' do
      it { is_expected.to be false }
    end

    context 'null policy (single null row in table) full access' do
      before { Gatekeeper.new.save! }
      it { is_expected.to be true }
    end

    context 'non-empty table without null row gives selective access' do
      let(:policy_maker) { PolicyMaker.new(requestor) }
      let(:requestor) { SubjectPolicyAgent.new(:Requestor, :requestor) }
      let(:any) { PolicyAgent.new(nil, nil) }

      before do
        # Allow requestor to make any policy for any object!
        Gatekeeper.new(
          subject_type: requestor.client_type,
          subject_id: requestor.client_id,
          verb_type: PolicyMaker::POLICY_ANY.client_type,
          verb_id: PolicyMaker::POLICY_ANY.client_id,
          object_type: any.client_type,
          object_id: any.client_id
        ).save!
      end

      it 'explicit policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent_id, object_agent_id)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent_id, object_agent_id)
        expect(policy_resolver.grant?).to be false
      end

      it 'explicit subject and verb policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent_id, object_agent_type)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent_id, object_agent_type)
        expect(policy_resolver.grant?).to be false
      end

      it 'explicit subject and object policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent_type, object_agent_id)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent_type, object_agent_id)
        expect(policy_resolver.grant?).to be false
      end

      it 'explicit subject policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent_type, object_agent_type)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent_type, object_agent_type)
        expect(policy_resolver.grant?).to be false
      end

      it 'explicit verb and object policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_type, verb_agent_id, object_agent_id)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_type, verb_agent_id, object_agent_id)
        expect(policy_resolver.grant?).to be false
      end

      it 'explicit verb policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_type, verb_agent_id, object_agent_type)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_type, verb_agent_id, object_agent_type)
        expect(policy_resolver.grant?).to be false
      end

      it 'explicit object policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_type, verb_agent_type, object_agent_id)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_type, verb_agent_type, object_agent_id)
        expect(policy_resolver.grant?).to be false
      end

      it 'implicit policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_type, verb_agent_type, object_agent_type)
        expect(policy_resolver.grant?).to be true
        policy_maker.revoke!(subject_agent_type, verb_agent_type, object_agent_type)
        expect(policy_resolver.grant?).to be false
      end
    end
  end
end

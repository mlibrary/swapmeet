# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyResolver do
  let(:policy) { described_class.new(subject_agent_id, verb_agent_id, object_agent_id) }
  let(:requestor_agent) { double('requestor agent') }
  let(:subject_agent) { double('subject agent type only') }
  let(:subject_agent_id) { double('subject agent type and id') }
  let(:verb_agent) { double('verb agent type only') }
  let(:verb_agent_id) { double('verb agent type and id') }
  let(:object_agent) { double('object agent type only') }
  let(:object_agent_id) { double('object agent type and id') }

  before do
    allow(requestor_agent).to receive(:client_type).and_return('requestor_type')
    allow(requestor_agent).to receive(:client_id).and_return('requestor_id')
    allow(subject_agent).to receive(:client_type).and_return('subject_type')
    allow(subject_agent).to receive(:client_id).and_return(nil.to_s)
    allow(subject_agent_id).to receive(:client_type).and_return('subject_type')
    allow(subject_agent_id).to receive(:client_id).and_return('subject_id')
    allow(verb_agent).to receive(:client_type).and_return('verb_type')
    allow(verb_agent).to receive(:client_id).and_return(nil.to_s)
    allow(verb_agent_id).to receive(:client_type).and_return('verb_type')
    allow(verb_agent_id).to receive(:client_id).and_return('verb_id')
    allow(object_agent).to receive(:client_type).and_return('object_type')
    allow(object_agent).to receive(:client_id).and_return(nil.to_s)
    allow(object_agent_id).to receive(:client_type).and_return('object_type')
    allow(object_agent_id).to receive(:client_id).and_return('object_id')
  end

  describe '#grant?' do
    subject { policy.grant? }

    context 'no policy (empty table) no access' do
      it { is_expected.to be false }
    end

    context 'null policy (single null row in table) full access' do
      before { Gatekeeper.new.save! }
      it { is_expected.to be true }
    end

    context 'non-empty table without null row gives selective access' do
      let(:policy_maker) { PolicyMaker.new(requestor_agent) }

      before do
        Gatekeeper.new(
          subject_type: 'requestor_type',
          subject_id: 'requestor_id',
          verb_type: 'Policy',
          verb_id: nil,
          object_type: nil,
          object_id: nil
        ).save!
      end

      it 'explicit policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent_id, object_agent_id)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent_id, object_agent_id)
        expect(policy.grant?).to be false
      end

      it 'explicit subject and verb policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent_id, object_agent)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent_id, object_agent)
        expect(policy.grant?).to be false
      end

      it 'explicit subject and object policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent, object_agent_id)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent, object_agent_id)
        expect(policy.grant?).to be false
      end

      it 'explicit subject policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent_id, verb_agent, object_agent)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent_id, verb_agent, object_agent)
        expect(policy.grant?).to be false
      end

      it 'explicit verb and object policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent, verb_agent_id, object_agent_id)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent, verb_agent_id, object_agent_id)
        expect(policy.grant?).to be false
      end

      it 'explicit verb policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent, verb_agent_id, object_agent)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent, verb_agent_id, object_agent)
        expect(policy.grant?).to be false
      end

      it 'explicit object policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent, verb_agent, object_agent_id)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent, verb_agent, object_agent_id)
        expect(policy.grant?).to be false
      end

      it 'implicit policy' do
        is_expected.to be false
        policy_maker.permit!(subject_agent, verb_agent, object_agent)
        expect(policy.grant?).to be true
        policy_maker.revoke!(subject_agent, verb_agent, object_agent)
        expect(policy.grant?).to be false
      end
    end
  end
end

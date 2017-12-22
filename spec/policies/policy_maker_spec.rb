# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyMaker do
  let(:policy_maker) { described_class.new(requestor_agent) }
  let(:requestor_agent) { double('requestor agent') }
  let(:subject_agent) { double('subject agent') }
  let(:verb_agent) { double('verb agent') }
  let(:object_agent) { double('object agent') }

  before do
    allow(requestor_agent).to receive(:client_type).and_return('requestor_type')
    allow(requestor_agent).to receive(:client_id).and_return('requestor_id')
    allow(subject_agent).to receive(:client_type).and_return('subject_type')
    allow(subject_agent).to receive(:client_id).and_return('subject_id')
    allow(verb_agent).to receive(:client_type).and_return('verb_type')
    allow(verb_agent).to receive(:client_id).and_return('verb_id')
    allow(object_agent).to receive(:client_type).and_return('object_type')
    allow(object_agent).to receive(:client_id).and_return('object_id')
  end

  describe '#permit!' do
    subject { policy_maker.permit!(subject_agent, verb_agent, object_agent) }

    it { pending("TODO: Bootstrap PolicyResolver to resolve verb(:Pending, :permit)"); is_expected.to be false }

    context 'grant' do
      before do
        allow(Gatekeeper).to receive(:where).and_call_original
        allow(Gatekeeper).to receive(:where).with("subject_type = ? AND subject_id = ? AND verb_type = ? AND verb_id = ? AND object_type = ? AND object_id = ?", 'requestor_type', 'requestor_id', 'Policy', 'permit', 'object_type', 'object_id').and_return([:any])
      end

      it { is_expected.to be true }
    end
  end

  describe '#revoke!' do
    subject { policy_maker.revoke!(subject_agent, verb_agent, object_agent) }

    it { pending("TODO: Bootstrap PolicyResolver to resolve verb(:Pending, :revoke)"); is_expected.to be false }

    context 'grant' do
      before do
        allow(Gatekeeper).to receive(:where).and_call_original
        allow(Gatekeeper).to receive(:where).with("subject_type = ? AND subject_id = ? AND verb_type = ? AND verb_id = ? AND object_type = ? AND object_id = ?", 'requestor_type', 'requestor_id', 'Policy', 'revoke', 'object_type', 'object_id').and_return([:any])
      end

      it { is_expected.to be true }
    end
  end

  context 'stress test' do
    subject { policy_maker }

    let(:policy_resolver) { PolicyResolver.new(subject_agent, verb_agent, object_agent) }

    before do
      allow(Gatekeeper).to receive(:where).and_call_original
      allow(Gatekeeper).to receive(:where).with("subject_type = ? AND subject_id = ? AND verb_type = ? AND verb_id = ? AND object_type = ? AND object_id = ?", 'requestor_type', 'requestor_id', 'Policy', 'permit', 'object_type', 'object_id').and_return([:any])
      allow(Gatekeeper).to receive(:where).with("subject_type = ? AND subject_id = ? AND verb_type = ? AND verb_id = ? AND object_type = ? AND object_id = ?", 'requestor_type', 'requestor_id', 'Policy', 'revoke', 'object_type', 'object_id').and_return([:any])
      policy_resolver
    end

    it do
      expect(policy_resolver.grant?).to be false

      policy_maker.permit!(subject_agent, verb_agent, object_agent)
      expect(policy_resolver.grant?).to be true

      policy_maker.revoke!(subject_agent, verb_agent, object_agent)
      expect(policy_resolver.grant?).to be false

      policy_maker.permit!(subject_agent, verb_agent, object_agent)
      expect(policy_resolver.grant?).to be true
      policy_maker.permit!(subject_agent, verb_agent, object_agent)
      expect(policy_resolver.grant?).to be true

      policy_maker.revoke!(subject_agent, verb_agent, object_agent)
      expect(policy_resolver.grant?).to be false
      policy_maker.revoke!(subject_agent, verb_agent, object_agent)
      expect(policy_resolver.grant?).to be false
    end
  end
end

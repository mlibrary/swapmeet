# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyResolver do
  let(:requestor_agent) { double('requestor agent') }
  let(:role_agent) { double('role agent') }
  let(:subject_agent) { double('subject agent') }
  let(:verb_agent) { double('verb agent') }
  let(:object_agent) { double('object agent') }

  before do
    allow(requestor_agent).to receive(:client_type).and_return('requestor_type')
    allow(requestor_agent).to receive(:client_id).and_return('requestor_id')
    allow(role_agent).to receive(:client_type).and_return('role_type')
    allow(role_agent).to receive(:client_id).and_return('role_id')
    allow(subject_agent).to receive(:client_type).and_return('subject_type')
    allow(subject_agent).to receive(:client_id).and_return('subject_id')
    allow(verb_agent).to receive(:client_type).and_return('verb_type')
    allow(verb_agent).to receive(:client_id).and_return('verb_id')
    allow(object_agent).to receive(:client_type).and_return('object_type')
    allow(object_agent).to receive(:client_id).and_return('object_id')
  end

  describe '#grant?' do
    subject { described_class.new(subject_agent, verb_agent, object_agent).grant? }

    it { is_expected.to be false }

    context '#permit!' do
      let(:policy_maker) { PolicyMaker.new(requestor_agent) }

      before do
        allow(Gatekeeper).to receive(:where).and_call_original
        allow(Gatekeeper).to receive(:where).with("subject_type = ? AND subject_id = ? AND verb_type = ? AND verb_id = ? AND object_type = ? AND object_id = ?", 'requestor_type', 'requestor_id', 'Policy', 'permit', 'object_type', 'object_id').and_return([:any])
        policy_maker.permit!(subject_agent, verb_agent, object_agent)
      end

      it { is_expected.to be true }
    end
  end
end

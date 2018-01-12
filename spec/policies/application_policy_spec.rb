# frozen_string_literal: true

require 'rails_helper'

require 'policy_errors'

RSpec.describe ApplicationPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  describe 'application policy' do
    subject { described_class.new(subject_agent, object_agent) }

    let(:subject_client) { double('subject client') }
    let(:subject_agent) { SubjectPolicyAgent.new(:Subject, subject_client) }
    let(:object_client) { double('object client') }
    let(:object_agent) { ObjectPolicyAgent.new(:Object, object_client) }

    context 'without permission' do
      it do
        expect(subject.verb?).to be false
        expect { subject.authorize!(:verb?, nil) }.to raise_error(NotAuthorizedError)
      end
    end

    context 'with permission' do
      let(:requestor_client) { double('requestor client') }
      let(:requestor_agent) { RequestorPolicyAgent.new(:Requestor, requestor_client) }

      before do
        # Allow requestor_agent.client to create any policy for object_agent.client
        Gatekeeper.new(
          subject_type: requestor_agent.client_type,
          subject_id: requestor_agent.client_id,
          verb_type: PolicyMaker::POLICY_ANY.client_type,
          verb_id: PolicyMaker::POLICY_ANY.client_id,
          object_type: object_agent.client_type,
          object_id: object_agent.client_id
        ).save!
        policy_maker = PolicyMaker.new(requestor_agent)
        policy_maker.permit!(subject_agent, VerbPolicyAgent.new(:Action, :verb), object_agent)
      end

      it do
        expect(subject.verb?).to be true
        expect { subject.authorize!(:verb?, nil) }.not_to raise_error
      end
    end
  end
end

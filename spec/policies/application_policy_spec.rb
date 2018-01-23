# frozen_string_literal: true

require 'rails_helper'

require 'policy_errors'

RSpec.describe ApplicationPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  describe 'application policy' do
    subject { described_class.new(subject_agent, object_agent) }

    let(:subject_agent) { SubjectPolicyAgent.new(:Subject, subject_client) }
    let(:subject_client) { double('subject client') }
    let(:object_agent) { ObjectPolicyAgent.new(:Object, object_client) }
    let(:object_client) { double('object client') }

    it '#respond_to? (a.k.a. #respond_to_missing?)' do
      expect(subject.respond_to?(:action?)).to be true
      expect(subject.respond_to?(:action)).to be false
    end

    context 'without permission' do
      it do
        expect(subject.action?).to be false
        expect { subject.authorize!(:action?, nil) }.to raise_error(NotAuthorizedError)
        expect { subject.authorize!(:action, nil) }.to raise_error(NoMethodError)
      end
    end

    context 'with permission' do
      before { PolicyMaker.permit!(subject_agent, ActionPolicyAgent.new(:action), object_agent) }
      it do
        expect(subject.action?).to be true
        expect { subject.authorize!(:action?, nil) }.not_to raise_error
        expect { subject.authorize!(:action, nil) }.to raise_error(NoMethodError)
      end
    end
  end
end

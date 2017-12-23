# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublishersPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  describe 'publishers policy' do
    subject { described_class.new(subject_agent, object_agent) }

    let(:subject_agent) { double('subject agent') }
    let(:object_agent) { double('object agent') }
    let(:client) { double('client') }
    let(:publisher) { double('publisher') }

    before do
      allow(subject_agent).to receive(:client_type).and_return(client_type)
      allow(subject_agent).to receive(:client_id).and_return(client_id)
      allow(subject_agent).to receive(:known?).and_return(known)
      allow(subject_agent).to receive(:application_administrator?).and_return(application_administrator)
      allow(subject_agent).to receive(:platform_administrator?).and_return(platform_administrator)
      allow(subject_agent).to receive(:client).and_return(client)
      allow(publisher).to receive(:administrator?).with(client).and_return(false)
      allow(object_agent).to receive(:client_type).and_return(client_type)
      allow(object_agent).to receive(:client_id).and_return(client_id)
    end

    context 'for anonymous user' do
      let(:client_type) { nil }
      let(:client_id) { nil }
      let(:known) { false }
      let(:application_administrator) { false }
      let(:platform_administrator) { false }
      it do
        expect(subject.index?).to be false
        expect(subject.show?).to be false
        expect(subject.create?).to be false
        expect(subject.update?).to be false
        expect(subject.destroy?).to be false
      end
      context 'for authenticated user' do
        let(:client_type) { :AnyType }
        let(:client_id) { 1 }
        let(:known) { true }
        it do
          expect(subject.index?).to be false
          expect(subject.show?).to be false
          expect(subject.create?).to be false
          expect(subject.update?).to be false
          expect(subject.destroy?).to be false
        end
        context 'with the role of application administrator' do
          let(:application_administrator) { true }
          it do
            expect(subject.index?).to be false
            expect(subject.show?).to be false
            expect(subject.create?).to be false
            expect(subject.update?).to be false
            expect(subject.destroy?).to be false
          end
        end
        context 'with the role of platform administrator' do
          let(:platform_administrator) { true }
          it do
            expect(subject.index?).to be true
            expect(subject.show?).to be true
            expect(subject.create?).to be true
            expect(subject.update?).to be true
            expect(subject.destroy?).to be true
          end
        end
        context 'with the role of publisher administrator' do
          before do
            allow(publisher).to receive(:administrator?).with(client).and_return(true)
            Gatekeeper.new(
              subject_type: client_type,
              subject_id: client_id,
              verb_type: 'Policy',
              verb_id: 'permit',
              object_type: client_type,
              object_id: client_id
            ).save!
            policy_maker = PolicyMaker.new(subject_agent)
            policy_maker.permit!(subject_agent, VerbPolicyAgent.new(:Action, :add), object_agent)
            policy_maker.permit!(subject_agent, VerbPolicyAgent.new(:Action, :remove), object_agent)
          end
          it do
            expect(subject.index?).to be false
            expect(subject.show?).to be false
            expect(subject.create?).to be false
            expect(subject.update?).to be false
            expect(subject.destroy?).to be false
            expect(subject.show?(publisher)).to be true
            expect(subject.update?(publisher)).to be true
            expect(subject.add?(publisher)).to be true
            expect(subject.remove?(publisher)).to be true
          end
        end
      end
    end
  end
end

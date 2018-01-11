# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewspapersPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  describe 'categories policy' do
    subject { described_class.new(subject_agent, object_agent) }

    let(:subject_agent) { double('subject agent') }
    let(:subject_client_type) { 'SubjectClientType' }
    let(:subject_client_id) { 'SubjectClientId' }
    let(:object_agent) { double('object agent') }
    let(:object_client_type) { 'ObjectClientType' }
    let(:object_client_id) { 'ObjectClientId' }

    before do
      allow(subject_agent).to receive(:known?).and_return(known)
      allow(subject_agent).to receive(:application_administrator?).and_return(application_administrator)
      allow(subject_agent).to receive(:platform_administrator?).and_return(platform_administrator)
      allow(subject_agent).to receive(:client_type).and_return(subject_client_type)
      allow(subject_agent).to receive(:client_id).and_return(subject_client_id)
      allow(object_agent).to receive(:client_type).and_return(object_client_type)
      allow(object_agent).to receive(:client_id).and_return(object_client_id)
    end

    context 'for anonymous user' do
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
            expect(subject.index?).to be false
            expect(subject.show?).to be false
            expect(subject.create?).to be false
            expect(subject.update?).to be false
            expect(subject.destroy?).to be false
          end
        end
      end
    end
  end
end

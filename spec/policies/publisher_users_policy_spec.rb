# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublisherUsersPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  let(:user_agent) { UserPolicyAgent.new(user) }
  let(:user) { double('user') }

  context 'Entity' do
    subject { described_class.new(entity_agent, user_agent) }

    let(:entity_agent) { SubjectPolicyAgent.new(:Entity, entity) }
    let(:entity) { double('entity') }

    it do
      expect(subject.index?).to be false
      expect(subject.show?).to be false
      expect(subject.create?).to be false
      expect(subject.update?).to be false
      expect(subject.destroy?).to be false
    end
    xit do
      expect(subject.join?).to be false
      expect(subject.leave?).to be false
    end
  end

  context 'User' do
    subject { described_class.new(current_user_agent, user_agent) }

    let(:current_user_agent) { SubjectPolicyAgent.new(:User, current_user) }
    let(:current_user) { double('current user') }

    before { allow(current_user_agent).to receive(:authenticated?).and_return(false) }
    it do
      expect(subject.index?).to be false
      expect(subject.show?).to be false
      expect(subject.create?).to be false
      expect(subject.update?).to be false
      expect(subject.destroy?).to be false
    end
    xit do
      expect(subject.join?).to be false
      expect(subject.leave?).to be false
    end

    context 'Authenticated' do
      before { allow(current_user_agent).to receive(:authenticated?).and_return(true) }
      it do
        expect(subject.index?).to be false
        expect(subject.show?).to be false
        expect(subject.create?).to be false
        expect(subject.update?).to be false
        expect(subject.destroy?).to be false
      end
      xit do
        expect(subject.join?).to be false
        expect(subject.leave?).to be false
      end

      context 'Grant' do
        before { PolicyMaker.permit!(PolicyMaker::USER_ANY, PolicyMaker::ACTION_ANY, PolicyMaker::OBJECT_ANY) }
        it do
          expect(subject.index?).to be false
          expect(subject.show?).to be true
          expect(subject.create?).to be true
          expect(subject.update?).to be true
          expect(subject.destroy?).to be true
        end
        xit do
          expect(subject.join?).to be true
          expect(subject.leave?).to be true
        end
      end

      context 'Publisher Agent' do
        subject { described_class.new(current_user_agent, publisher_agent) }
        let(:publisher_agent) { PublisherPolicyAgent.new(publisher_object) }
        let(:publisher_object) { nil }
        it { expect(subject.index?).to be false }
        context 'Publisher Object' do
          let(:publisher_object) { create(:publisher, users: publisher_users) }
          let(:publisher_users) { [] }
          it { expect(subject.index?).to be false }
          context 'Publisher Object User' do
            let(:publisher_users) { [current_user] }
            let(:current_user) { create(:user) }
            it { expect(subject.index?).to be true }
          end
        end
      end
    end
  end
end
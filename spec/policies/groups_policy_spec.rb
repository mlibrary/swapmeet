# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  let(:group_agent) { GroupPolicyAgent.new(group) }
  let(:group) { double('group') }

  context 'Entity' do
    subject { described_class.new([entity_agent, group_agent]) }

    let(:entity_agent) { SubjectPolicyAgent.new(:Entity, entity) }
    let(:entity) { double('entity') }

    it do
      expect(subject.index?).to be false
      expect(subject.show?).to be false
      expect(subject.create?).to be false
      expect(subject.update?).to be false
      expect(subject.destroy?).to be false
      expect(subject.add?).to be false
      expect(subject.remove?).to be false
    end
  end

  context 'User' do
    subject { described_class.new([user_agent, group_agent]) }

    let(:user_agent) { SubjectPolicyAgent.new(:User, user) }
    let(:user) { double('user') }

    before { allow(user_agent).to receive(:authenticated?).and_return(false) }
    it do
      expect(subject.index?).to be false
      expect(subject.show?).to be false
      expect(subject.create?).to be false
      expect(subject.update?).to be false
      expect(subject.destroy?).to be false
      expect(subject.add?).to be false
      expect(subject.remove?).to be false
    end

    context 'Authenticated' do
      before { allow(user_agent).to receive(:authenticated?).and_return(true) }
      it do
        expect(subject.index?).to be true
        expect(subject.show?).to be true
        expect(subject.create?).to be false
        expect(subject.update?).to be false
        expect(subject.destroy?).to be false
        expect(subject.add?).to be false
        expect(subject.remove?).to be false
      end

      context 'Grant' do
        before { PolicyMaker.permit!(PolicyMaker::USER_ANY, PolicyMaker::ACTION_ANY, PolicyMaker::OBJECT_ANY) }
        it do
          expect(subject.index?).to be true
          expect(subject.show?).to be true
          expect(subject.create?).to be true
          expect(subject.update?).to be true
          expect(subject.destroy?).to be true
          expect(subject.add?).to be true
          expect(subject.remove?).to be true
        end
      end
    end
  end
end
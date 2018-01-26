# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { double('user') }
  let(:policy) { double('policy') }
  let(:model) { double('model') }

  it { is_expected.to be_a(described_class) }

  context 'user delegation' do
    before do
    end
    it do
      expect(subject.user).to be user
    end
  end

  context 'policy delegation' do
    before do
      allow(policy).to receive(:index?).and_return(:index?)
      allow(policy).to receive(:show?).and_return(:show?)
      allow(policy).to receive(:new?).and_return(:new?)
      allow(policy).to receive(:create?).and_return(:create?)
      allow(policy).to receive(:edit?).and_return(:edit?)
      allow(policy).to receive(:update?).and_return(:update?)
      allow(policy).to receive(:destroy?).and_return(:destroy?)
    end
    it do
      expect(subject.policy).to be policy
      expect(subject.index?).to be :index?
      expect(subject.show?).to be :show?
      expect(subject.new?).to be :new?
      expect(subject.create?).to be :create?
      expect(subject.edit?).to be :edit?
      expect(subject.update?).to be :update?
      expect(subject.destroy?).to be :destroy?
    end
  end

  context 'model delegation' do
    before do
      allow(model).to receive(:to_model).and_return(:to_model)
      allow(model).to receive(:errors).and_return(:errors)
      allow(model).to receive(:persisted?).and_return(:persisted?)
    end
    it do
      expect(subject.model).to be model
      expect(subject.to_model).to be :to_model
      expect(subject.errors).to be :errors
      expect(subject.persisted?).to be :persisted?
    end
  end

  describe '#administrator?' do
    subject { presenter.administrator?(object_presenter) }
    let(:user) { SubjectPolicyAgent.new(:User, :user) }
    let(:policy) { ApplicationPolicy.new(user, model) }
    let(:model) { ObjectPolicyAgent.new(:Model, :model) }

    context 'subject' do
      let(:object_presenter) { nil }
      it { is_expected.to be false }
      context 'administrator' do
        before {  PolicyMaker.permit!(user, PolicyMaker::ROLE_ADMINISTRATOR, policy.object) }
        it { is_expected.to be true }
      end
    end

    context 'object' do
      let(:object_presenter) { described_class.new(user, policy, model) }
      it { is_expected.to be false }
      context 'administrator' do
        before {  PolicyMaker.permit!(model, PolicyMaker::ROLE_ADMINISTRATOR, policy.object) }
        it { is_expected.to be true }
      end
    end
  end
end

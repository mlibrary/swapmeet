# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { ListingPolicy.new(SubjectPolicyAgent.new(:User, user), ListingPolicyAgent.new(model)) }
  let(:model) { build(:listing, owner: owner, category: category, newspaper: newspaper) }
  let(:owner) { nil }
  let(:category) { nil }
  let(:newspaper) { nil }

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
    end
    it do
      expect(subject.policy).to be policy
    end
  end

  context 'model delegation' do
    before do
    end
    it do
      expect(subject.model).to be model
      expect(subject.title).to be model.title
      expect(subject.body).to be model.body
    end
  end

  describe '#label' do
    subject { presenter.label }
    it do
      is_expected.to be_a(String)
      is_expected.to eq model.title
    end
  end

  describe '#category?' do
    subject { presenter.category? }
    context 'blank' do
      let(:category) { nil }
      it { is_expected.to be false }
    end
    context 'present' do
      let(:category) { build(:category) }
      it { is_expected.to be true }
    end
  end

  describe '#category' do
    subject { presenter.category }
    let(:category) { build(:category) }
    it do
      is_expected.to be_a(CategoryPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(CategoriesPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(CategoryPolicyAgent)
      expect(subject.policy.object.client_type).to eq :Category.to_s
      expect(subject.policy.object.client).to be model.category
      expect(subject.model).to be category
    end
  end

  describe '#categories' do
    subject { presenter.categories }
    it do
      is_expected.to be_a(Array)
    end
  end

  describe '#newspaper?' do
    subject { presenter.newspaper? }
    context 'blank' do
      let(:newspaper) { nil }
      it { is_expected.to be false }
    end
    context 'present' do
      let(:newspaper) { build(:newspaper) }
      it { is_expected.to be true }
    end
  end

  describe '#newspaper' do
    subject { presenter.newspaper }
    let(:newspaper) { build(:newspaper) }
    it do
      is_expected.to be_a(NewspaperPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(NewspapersPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(NewspaperPolicyAgent)
      expect(subject.policy.object.client_type).to eq :Newspaper.to_s
      expect(subject.policy.object.client).to be model.newspaper
      expect(subject.model).to be model.newspaper
    end
  end

  describe '#newspapers' do
    subject { presenter.newspapers }
    it do
      is_expected.to be_a(Array)
    end
  end

  describe '#owner?' do
    subject { presenter.owner? }
    context 'blank' do
      let(:owner) { nil }
      it { is_expected.to be false }
    end
    context 'present' do
      let(:owner) { build(:user) }
      it { is_expected.to be true }
    end
  end

  describe '#owner' do
    subject { presenter.owner }
    let(:owner) { build(:user) }
    it do
      is_expected.to be_a(UserPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(UsersPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(UserPolicyAgent)
      expect(subject.policy.object.client_type).to eq :User.to_s
      expect(subject.policy.object.client).to be model.owner
      expect(subject.model).to be model.owner
    end
  end
end

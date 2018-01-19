# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { ListingPolicy.new(UserPolicyAgent.new(user), ListingPolicyAgent.new(model)) }
  let(:model) { build(:listing) }

  it { is_expected.to be_a(described_class) }

  describe '#label' do
    subject { presenter.label }
    it do
      is_expected.to be_a(String)
      is_expected.to eq model.title
    end
  end

  describe '#category' do
    subject { presenter.category }
    it do
      is_expected.to be_a(CategoryPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(CategoriesPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(PolicyAgent)
      expect(subject.policy.object.client_type).to eq :Category.to_s
      expect(subject.policy.object.client).to be model.category
      expect(subject.model).to be
    end
  end

  describe '#newspaper' do
    subject { presenter.newspaper }
    it do
      is_expected.to be_a(NewspaperPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(NewspapersPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(PolicyAgent)
      expect(subject.policy.object.client_type).to eq :Newspaper.to_s
      expect(subject.policy.object.client).to be model.newspaper
      expect(subject.model).to be model.newspaper
    end
  end

  describe '#owner' do
    subject { presenter.owner }
    it do
      is_expected.to be_a(UserPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(UsersPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(PolicyAgent)
      expect(subject.policy.object.client_type).to eq :User.to_s
      expect(subject.policy.object.client).to be model.owner
      expect(subject.model).to be model.owner
    end
  end
end

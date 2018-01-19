# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { ListingPolicy.new(UserPolicyAgent.new(user), ListingPolicyAgent.new(model)) }
  let(:model) { build(:listing) }

  it do
    is_expected.to be_a(ListingPresenter)
  end

  describe '#label' do
    subject { presenter.label }
    it do
      is_expected.to be_a(String)
    end
  end

  describe '#category' do
    subject { presenter.category }
    it do
      is_expected.to be_a(CategoryPresenter)
      expect(subject.model).to be model.category
    end
  end

  describe '#newspaper' do
    subject { presenter.newspaper }
    it do
      is_expected.to be_a(NewspaperPresenter)
    end
  end

  describe '#owner' do
    subject { presenter.owner }
    it do
      is_expected.to be_a(UserPresenter)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { CategoriesPolicy.new(UserPolicyAgent.new(user), ObjectPolicyAgent.new(:Catagory, model)) }
  let(:model) { build(:category, listings: listings) }
  let(:listings) do
    [
        build(:listing),
        build(:listing),
        build(:listing)
    ]
  end

  it { is_expected.to be_a(described_class) }

  describe '#label' do
    subject { presenter.label }
    it do
      is_expected.to be_a(String)
      is_expected.to eq model.display_name
    end
  end

  describe '#listings' do
    subject { presenter.listings }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq listings.count
      subject.each.with_index do |listing, index|
        expect(listing).to be_a(ListingPresenter)
        expect(listing.user).to be user
        expect(listing.policy).to be_a(ListingPolicy)
        expect(listing.policy.subject).to be policy.subject
        expect(listing.policy.object).to be_a(PolicyAgent)
        expect(listing.policy.object.client_type).to eq :Listing.to_s
        expect(listing.policy.object.client).to be listings[index]
        expect(listing.model).to be listings[index]
      end
    end
  end
end

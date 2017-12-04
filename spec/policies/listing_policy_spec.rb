require 'rails_helper'

RSpec.describe ListingPolicy do
  subject(:policy) { ListingPolicy.new(user, listing) }
  let(:user)       { User.new }
  let(:other_user) { User.new }
  let(:nobody)     { Nobody.new }

  context "when user owns the listing" do
    let(:user) { create(:user) }
    let(:listing) { create(:listing, owner: user) }

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "allows destroy" do
      expect(policy.destroy?).to be true
    end
  end

  context "when a different user owns the listing" do
    let(:listing) { Listing.new(owner: other_user) }

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "rejects destroy" do
      expect(policy.destroy?).to be false
    end
  end

  context "when nobody owns the listing" do
    let(:listing) { Listing.new(owner: nil) }

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "rejects destroy" do
      expect(policy.destroy?).to be false
    end
  end
end

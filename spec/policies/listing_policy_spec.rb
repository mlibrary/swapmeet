# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/checkpoint_helpers'

RSpec.describe ListingPolicy do
  subject { policy }

  let(:policy)        { ListingPolicy.new(user, listing) }
  let(:user)          { User.new }
  let(:other_user)    { User.new }
  let(:listing)       { create(:listing, owner: listing_owner) }
  let(:listing_owner) { double('Listing Owner') }

  before(:each) do
    user.identity = {}
  end

  context "when user is a guest" do
    let(:user) { User.guest }
    let(:listing_owner) { other_user }

    it "denies create" do
      expect(policy.create?).to be false
    end

    it "denies destroy" do
      expect(policy.destroy?).to be false
    end

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "denies update" do
      expect(policy.update?).to be false
    end
  end

  context "when user is an admin" do
    let(:listing_owner) { other_user }

    before do
      allow(user).to receive(:persisted?).and_return(true)
      allow(user).to receive(:username).and_return('userid')
      new_permit(agent(id: 'userid'), make_role('admin'), all_resources).save
    end

    it "allows create" do
      expect(policy.create?).to be true
    end

    it "allows destroy" do
      expect(policy.destroy?).to be true
    end

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "allows update" do
      expect(policy.update?).to be true
    end
    after do
      Checkpoint::DB.db[:grants].delete
    end
  end

  context "when user owns the listing" do
    let(:listing_owner) { user }

    it "allows create" do
      expect(policy.create?).to be true
    end

    it "allows destroy" do
      expect(policy.destroy?).to be true
    end

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "allows update" do
      expect(policy.update?).to be true
    end
  end

  context "when a different user owns the listing" do
    let(:listing_owner) { other_user }

    it "denies create" do
      expect(policy.create?).to be false
    end

    it "denies destroy" do
      expect(policy.destroy?).to be false
    end

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "denies update" do
      expect(policy.update?).to be false
    end
  end

end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingPolicy do
  subject { policy }

  let(:policy)        { ListingPolicy.new(user, listing) }
  let(:user)          { User.new }
  let(:other_user)    { User.new }
  let(:listing)       { create(:listing, owner: listing_owner) }
  let(:listing_owner) { double('Listing Owner') }

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
      Checkpoint::DB::db[:permits].delete
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

  def new_permit(agent, credential, resource, zone: 'system')
    Checkpoint::DB::Permit.from(agent, credential, resource, zone: zone)
  end

  def agent(type: 'user', id: 'userid')
    actor = double('actor', agent_type: type, id: id)
    Checkpoint::Agent.new(actor)
  end

  def make_role(name)
    Checkpoint::Credential::Role.new(name)
  end

  def make_permission(name)
    Checkpoint::Credential::Permission.new(name)
  end

  def all_resources
    Checkpoint::Resource.all
  end

  def resource(type: 'resource', id: 1)
    entity = double('entity', resource_type: type, id: id)
    Checkpoint::Resource.from(entity)
  end
end

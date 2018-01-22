# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewspaperPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { NewspapersPolicy.new(SubjectPolicyAgent.new(:User, user), NewspaperPolicyAgent.new(model)) }
  let(:model) { build(:newspaper, listings: listings, groups: groups, users: users) }
  let(:listings) do
    [
        build(:listing),
        build(:listing),
        build(:listing)
    ]
  end
  let(:groups) do
    [
        build(:group),
        build(:group),
        build(:group)
    ]
  end
  let(:users) do
    [
        build(:user),
        build(:user),
        build(:user)
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

  describe '#publisher' do
    subject { presenter.publisher }
    it do
      is_expected.to be_a(PublisherPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(PublishersPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(PublisherPolicyAgent)
      expect(subject.policy.object.client_type).to eq :Publisher.to_s
      expect(subject.policy.object.client).to be model.publisher
      expect(subject.model).to be model.publisher
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
        expect(listing.policy.object).to be_a(ListingPolicyAgent)
        expect(listing.policy.object.client_type).to eq :Listing.to_s
        expect(listing.policy.object.client).to be listings[index]
        expect(listing.model).to be listings[index]
      end
    end
  end

  describe '#groups' do
    subject { presenter.groups }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq groups.count
      subject.each.with_index do |group, index|
        expect(group).to be_a(GroupPresenter)
        expect(group.user).to be user
        expect(group.policy).to be_a(GroupsPolicy)
        expect(group.policy.subject).to be policy.subject
        expect(group.policy.object).to be_a(GroupPolicyAgent)
        expect(group.policy.object.client_type).to eq :Group.to_s
        expect(group.policy.object.client).to be groups[index]
        expect(group.model).to be groups[index]
      end
    end
  end

  describe '#users' do
    subject { presenter.users }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq users.count
      subject.each.with_index do |usr, index|
        expect(usr).to be_a(UserPresenter)
        expect(usr.user).to be user
        expect(usr.policy).to be_a(UsersPolicy)
        expect(usr.policy.subject).to be policy.subject
        expect(usr.policy.object).to be_a(UserPolicyAgent)
        expect(usr.policy.object.client_type).to eq :User.to_s
        expect(usr.policy.object.client).to be users[index]
        expect(usr.model).to be users[index]
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublisherPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { PublishersPolicy.new(SubjectPolicyAgent.new(:User, user), PublisherPolicyAgent.new(model)) }
  let(:model) { build(:publisher, domain: domain, newspapers: newspapers, groups: groups, users: users) }
  let(:domain) { build(:domain) }
  let(:newspapers) do
    [
        build(:newspaper),
        build(:newspaper),
        build(:newspaper)
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

  describe '#domain' do
    subject { presenter.domain }
    it do
      is_expected.to be_a(DomainPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(DomainsPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(DomainPolicyAgent)
      expect(subject.policy.object.client_type).to eq :Domain.to_s
      expect(subject.policy.object.client).to be model.domain
      expect(subject.model).to be model.domain
    end
  end

  describe '#newspapers' do
    subject { presenter.newspapers }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq newspapers.count
      subject.each.with_index do |newspaper, index|
        expect(newspaper).to be_a(NewspaperPresenter)
        expect(newspaper.user).to be user
        expect(newspaper.policy).to be_a(NewspapersPolicy)
        expect(newspaper.policy.subject).to be policy.subject
        expect(newspaper.policy.object).to be_a(NewspaperPolicyAgent)
        expect(newspaper.policy.object.client_type).to eq :Newspaper.to_s
        expect(newspaper.policy.object.client).to be newspapers[index]
        expect(newspaper.model).to be newspapers[index]
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

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { GroupsPolicy.new(SubjectPolicyAgent.new(:User, user), GroupPolicyAgent.new(model)) }
  let(:model) { build(:group, parent: parent, children: children, users: users, publishers: publishers, newspapers: newspapers) }
  let(:parent) { build(:group) }
  let(:children) do
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
  let(:publishers) do
    [
        build(:publisher),
        build(:publisher),
        build(:publisher)
    ]
  end
  let(:newspapers) do
    [
        build(:newspaper),
        build(:newspaper),
        build(:newspaper)
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

  describe '#parent' do
    subject { presenter.parent }
    it do
      is_expected.to be_a(GroupPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(GroupsPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(GroupPolicyAgent)
      expect(subject.policy.object.client_type).to eq :Group.to_s
      expect(subject.policy.object.client).to be model.parent
      expect(subject.model).to be model.parent
    end
  end

  describe '#children' do
    subject { presenter.children }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq children.count
      subject.each.with_index do |group, index|
        expect(group).to be_a(GroupPresenter)
        expect(group.user).to be user
        expect(group.policy).to be_a(GroupsPolicy)
        expect(group.policy.subject).to be policy.subject
        expect(group.policy.object).to be_a(GroupPolicyAgent)
        expect(group.policy.object.client_type).to eq :Group.to_s
        expect(group.policy.object.client).to be children[index]
        expect(group.model).to be children[index]
      end
    end
  end

  describe '#publishers' do
    subject { presenter.publishers }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq publishers.count
      subject.each.with_index do |publisher, index|
        expect(publisher).to be_a(PublisherPresenter)
        expect(publisher.user).to be user
        expect(publisher.policy).to be_a(PublishersPolicy)
        expect(publisher.policy.subject).to be policy.subject
        expect(publisher.policy.object).to be_a(PublisherPolicyAgent)
        expect(publisher.policy.object.client_type).to eq :Publisher.to_s
        expect(publisher.policy.object.client).to be publishers[index]
        expect(publisher.model).to be publishers[index]
      end
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

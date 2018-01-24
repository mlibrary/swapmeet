# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupEditor do
  subject { editor }

  let(:editor) { described_class.new(user, policy, model) }
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
      expect(subject.name).to be model.name
      expect(subject.display_name).to be model.display_name
      expect(subject.parent).to be parent
      expect(subject.children).to eq children
      expect(subject.users).to eq users
      expect(subject.publishers).to eq publishers
      expect(subject.newspapers).to eq newspapers
    end
  end

  describe '#parent?' do
    subject { editor.parent? }
    let(:boolean) { double('boolean') }
    before do
      allow(parent).to receive(:present?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#children?' do
    subject { editor.children? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:children).and_return(children)
      allow(children).to receive(:empty?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#users?' do
    subject { editor.users? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:users).and_return(users)
      allow(users).to receive(:empty?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#publishers?' do
    subject { editor.publishers? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:publishers).and_return(publishers)
      allow(publishers).to receive(:empty?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#newspapers?' do
    subject { editor.newspapers? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:newspapers).and_return(newspapers)
      allow(newspapers).to receive(:empty?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#groups' do
    subject { editor.groups }
    it do
      is_expected.to be_a(Array)
    end
  end
end

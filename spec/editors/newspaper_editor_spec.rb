# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewspaperEditor do
  subject { editor }

  let(:editor) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { NewspapersPolicy.new(SubjectPolicyAgent.new(:User, user), NewspaperPolicyAgent.new(model)) }
  let(:model) { build(:newspaper, listings: listings, groups: groups, users: users) }
  let(:publisher) { build(:publisher) }
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
      expect(subject.publisher).to be model.publisher
      expect(subject.listings).to eq listings
      expect(subject.users).to eq users
      expect(subject.groups).to eq groups
    end
  end

  describe '#publisher?' do
    subject { editor.publisher? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:publisher).and_return(publisher)
      allow(publisher).to receive(:present?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#listings?' do
    subject { editor.listings? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:listings).and_return(listings)
      allow(listings).to receive(:empty?).and_return(boolean)
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

  describe '#groups?' do
    subject { editor.groups? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:groups).and_return(groups)
      allow(groups).to receive(:empty?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#publishers' do
    subject { editor.publishers }
    it do
      is_expected.to be_a(Array)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEditor do
  subject { editor }

  let(:editor) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { UsersPolicy.new(SubjectPolicyAgent.new(:User, user), UserPolicyAgent.new(model)) }
  let(:model) { build(:user, listings: listings, newspapers: newspapers, publishers: publishers, groups: groups) }
  let(:listings) do
    [
        build(:listing),
        build(:listing),
        build(:listing)
    ]
  end
  let(:newspapers) do
    [
        build(:newspaper),
        build(:newspaper),
        build(:newspaper)
    ]
  end
  let(:publishers) do
    [
        build(:publisher),
        build(:publisher),
        build(:publisher)
    ]
  end
  let(:groups) do
    [
        build(:group),
        build(:group),
        build(:group)
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
      expect(subject.username).to be model.username
      expect(subject.email).to be model.email
      expect(subject.listings).to eq listings
      expect(subject.newspapers).to eq newspapers
      expect(subject.publishers).to eq publishers
      expect(subject.groups).to eq groups
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

end

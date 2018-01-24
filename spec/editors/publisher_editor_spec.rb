# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublisherEditor do
  subject { editor }

  let(:editor) { described_class.new(user, policy, model) }
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
      expect(subject.domain).to be domain
      expect(subject.newspapers).to eq newspapers
      expect(subject.users).to eq users
      expect(subject.groups).to eq groups
    end
  end

  describe '#domain?' do
    subject { editor.domain? }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:domain).and_return(domain)
      allow(domain).to receive(:present?).and_return(boolean)
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

  describe '#domains' do
    subject { editor.domains }
    it do
      is_expected.to be_a(Array)
    end
  end
end

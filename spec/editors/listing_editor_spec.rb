# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingEditor do
  subject { editor }

  let(:editor) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { ListingPolicy.new(SubjectPolicyAgent.new(:User, user), ListingPolicyAgent.new(model)) }
  let(:model) { build(:listing) }

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
      expect(subject.title).to be model.title
      expect(subject.body).to be model.body
      expect(subject.owner).to be model.owner
      expect(subject.category).to be model.category
      expect(subject.newspaper).to be model.newspaper
    end
  end

  describe '#owner?' do
    subject { editor.owner? }
    let(:owner) { double('owner') }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:owner).and_return(owner)
      allow(owner).to receive(:present?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#category?' do
    subject { editor.category? }
    let(:category) { double('category') }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:category).and_return(category)
      allow(category).to receive(:present?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#categories' do
    subject { editor.categories }
    it do
      is_expected.to be_a(Array)
    end
  end

  describe '#newspaper?' do
    subject { editor.newspaper? }
    let(:newspaper) { double('newspaper') }
    let(:boolean) { double('boolean') }
    before do
      allow(model).to receive(:newspaper).and_return(newspaper)
      allow(newspaper).to receive(:present?).and_return(boolean)
    end
    it do
      is_expected.to be boolean
    end
  end

  describe '#newspapers' do
    subject { editor.newspapers }
    it do
      is_expected.to be_a(Array)
    end
  end
end

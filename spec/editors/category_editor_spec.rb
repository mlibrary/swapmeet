# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryEditor do
  subject { editor }

  let(:editor) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { CategoriesPolicy.new(SubjectPolicyAgent.new(:User, user), CategoryPolicyAgent.new(model)) }
  let(:model) { build(:category, listings: listings) }
  let(:listings) do
    [
        build(:listing),
        build(:listing),
        build(:listing)
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
      expect(subject.title).to be model.title
      expect(subject.listings).to eq listings
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
end

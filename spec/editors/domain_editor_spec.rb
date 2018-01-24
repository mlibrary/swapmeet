# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainEditor do
  subject { editor }

  let(:editor) { described_class.new(user, policy, model) }
  let(:user) { build(:user) }
  let(:policy) { DomainsPolicy.new(SubjectPolicyAgent.new(:User, user), DomainPolicyAgent.new(model)) }
  let(:model) { build(:domain, parent: parent, children: children, publishers: publishers) }
  let(:parent) { build(:domain) }
  let(:children) do
    [
        build(:domain),
        build(:domain),
        build(:domain)
    ]
  end
  let(:publishers) do
    [
        build(:publisher),
        build(:publisher),
        build(:publisher)
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
      expect(subject.publishers).to eq publishers
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

  describe '#domains' do
    subject { editor.domains }
    it do
      is_expected.to be_a(Array)
    end
  end
end

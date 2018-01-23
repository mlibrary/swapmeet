# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
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
      is_expected.to be_a(DomainPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(DomainsPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be_a(DomainPolicyAgent)
      expect(subject.policy.object.client_type).to eq :Domain.to_s
      expect(subject.policy.object.client).to be model.parent
      expect(subject.model).to be model.parent
    end
  end

  describe '#children' do
    subject { presenter.children }
    it do
      is_expected.to be_a(DomainsPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(DomainsPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be policy.object
      expect(subject.count).to eq children.count
      subject.each.with_index do |domain, index|
        expect(domain).to be_a(DomainPresenter)
        expect(domain.user).to be user
        expect(domain.policy).to be_a(DomainsPolicy)
        expect(domain.policy.subject).to be policy.subject
        expect(domain.policy.object).to be_a(DomainPolicyAgent)
        expect(domain.policy.object.client_type).to eq :Domain.to_s
        expect(domain.policy.object.client).to be children[index]
        expect(domain.model).to be children[index]
      end
    end
  end

  describe '#publishers' do
    subject { presenter.publishers }
    it do
      is_expected.to be_a(PublishersPresenter)
      expect(subject.user).to be user
      expect(subject.policy).to be_a(PublishersPolicy)
      expect(subject.policy.subject).to be policy.subject
      expect(subject.policy.object).to be policy.object
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
end

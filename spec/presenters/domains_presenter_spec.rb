# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainsPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, models) }
  let(:user) { build(:user) }
  let(:policy) { DomainsPolicy.new(SubjectPolicyAgent.new(:User, user), nil) }
  let(:models) { domains }
  let(:domains) do
    [
        build(:domain),
        build(:domain),
        build(:domain)
    ]
  end

  it { is_expected.to be_a(described_class) }

  describe 'presenters' do
    subject { presenter.presenters }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq models.count
      subject.each.with_index do |model_presenter, index|
        expect(model_presenter).to be_a(DomainPresenter)
        expect(model_presenter.user).to be user
        expect(model_presenter.policy).to be_a(DomainsPolicy)
        expect(model_presenter.policy.subject).to be policy.subject
        expect(model_presenter.policy.object).to be_a(DomainPolicyAgent)
        expect(model_presenter.policy.object.client_type).to eq :Domain.to_s
        expect(model_presenter.policy.object.client).to be domains[index]
        expect(model_presenter.model).to be domains[index]
      end
    end
  end
end

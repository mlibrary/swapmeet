# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, models) }
  let(:user) { build(:user) }
  let(:policy) { CategoriesPolicy.new([SubjectPolicyAgent.new(:User, user), nil]) }
  let(:models) { categories }
  let(:categories) do
    [
        build(:category),
        build(:category),
        build(:category)
    ]
  end

  it { is_expected.to be_a(described_class) }

  describe 'presenters' do
    subject { presenter.presenters }
    it do
      is_expected.to be_a(Array)
      expect(subject.count).to eq models.count
      subject.each.with_index do |model_presenter, index|
        expect(model_presenter).to be_a(CategoryPresenter)
        expect(model_presenter.user).to be user
        expect(model_presenter.policy).to be_a(CategoriesPolicy)
        expect(model_presenter.policy.subject_agent).to be policy.subject_agent
        expect(model_presenter.policy.object_agent).to be_a(CategoryPolicyAgent)
        expect(model_presenter.policy.object_agent.client_type).to eq :Category.to_s
        expect(model_presenter.policy.object_agent.client).to be categories[index]
        expect(model_presenter.model).to be categories[index]
      end
    end
  end
end
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RootPolicy, type: :policy do
  it_should_behave_like 'an application policy'

  describe '#administrator_user?' do
    subject { described_class.new(entity_agent, nil).administrator_user?(user) }

    let(:entity_agent) { SubjectPolicyAgent.new(:Entity, entity) }
    let(:entity) { double('entity') }
    let(:policy_maker) { double('policy maker') }
    let(:user_agent) { double('user agent') }
    let(:user) { double('user') }
    let(:role_agent) { double('role agent') }
    let(:boolean) { double('boolean') }

    before do
      allow(PolicyMaker).to receive(:new).with(entity_agent).and_return(policy_maker)
      allow(UserPolicyAgent).to receive(:new).with(user).and_return(user_agent)
      allow(RolePolicyAgent).to receive(:new).with(:administrator).and_return(role_agent)
      allow(policy_maker).to receive(:exist?).with(user_agent, role_agent, PolicyMaker::OBJECT_ANY).and_return(boolean)
    end

    it { is_expected.to be boolean }
  end

  describe '#method_missing' do
    subject { described_class.new(nil, nil).method? }
    it { is_expected.to be true }
  end
end

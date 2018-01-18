# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  describe '#new' do
    context 'default' do
      subject { described_class.new }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Publisher
        expect(subject.name).to be_nil
        expect(subject.display_name).to be_nil
        expect(subject.domain_id).to be_nil
      end
    end
    context 'create' do
      subject { create(:publisher, name: 'Name', display_name: 'Display Name') }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Publisher
        expect(subject.name).to eq 'Name'
        expect(subject.display_name).to eq 'Display Name'
        expect(subject.domain_id).to be_nil
      end
    end
  end

  describe '#administrator?' do
    subject { publisher.administrator?(user) }
    let(:publisher) { described_class.new }
    let(:user) { double('user') }
    let(:policy_resolver) { double('policy_resolver') }
    let(:user_agent) { double('user_agent') }
    let(:role_agent) { double('role agent') }
    let(:publisher_agent) { double('publisher_agent') }
    let(:boolean) { double('boolean') }
    before do
      allow(PolicyResolver).to receive(:new).with(user_agent, role_agent, publisher_agent).and_return(policy_resolver)
      allow(UserPolicyAgent).to receive(:new).with(user).and_return(user_agent)
      allow(RolePolicyAgent).to receive(:new).with(:administrator).and_return(role_agent)
      allow(ObjectPolicyAgent).to receive(:new).with(:Publisher, publisher).and_return(publisher_agent)
      allow(policy_resolver).to receive(:grant?).and_return(boolean)
    end
    it { is_expected.to be boolean }
  end

  describe '#user?' do
    subject { publisher.user?(user) }
    let(:publisher) { described_class.new }
    let(:user) { double('user') }
    let(:users) { double('users') }
    let(:id) { double('id') }
    let(:boolean) { double('boolean') }
    before do
      allow(publisher).to receive(:users).and_return(users)
      allow(user).to receive(:id).and_return(id)
      allow(users).to receive(:exists?).with(id).and_return(boolean)
    end
    it { is_expected.to be boolean }
  end
end

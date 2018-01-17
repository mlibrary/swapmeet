# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicyAgent do
  subject { user_agent }

  let(:user_agent) { described_class.new(user) }
  let(:user) { double('user') }

  before { allow(user).to receive(:known?).and_return false }

  it { is_expected.to be_a(SubjectPolicyAgent) }
  it { expect(subject.client_type).to eq :User.to_s }
  it { expect(subject.client_id).to eq user.to_s }
  it { expect(subject.client).to be user }

  describe '#anonymous?' do
    it do
      is_expected.to receive(:authenticated?)
      subject.anonymous?
    end
    it { expect(subject.anonymous?).to eq !subject.authenticated? }
  end

  describe '#authenticated?' do
    subject { user_agent.authenticated? }
    it { is_expected.to be false }
    context 'known' do
      before do
        allow(user).to receive(:known?).and_return(true)
      end
      it { is_expected.to be true }
    end
  end
end

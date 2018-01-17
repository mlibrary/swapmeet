# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicyAgent do
  subject { described_class.new(user_client) }
  let(:user_client) { double('user') }
  before { allow(user_client).to receive(:known?).and_return false }
  it { is_expected.to be_a(SubjectPolicyAgent) }
  it { expect(subject.client_type).to eq "User" }

  describe '#anonymous?' do
    it do
      is_expected.to receive(:authenticated?)
      subject.anonymous?
    end
    it { expect(subject.anonymous?).to eq !subject.authenticated? }
  end

  describe '#authenticated?' do
    subject { described_class.new(user_client).authenticated? }
    it { is_expected.to be false }
    context 'known' do
      before do
        allow(user_client).to receive(:known?).and_return(true)
      end
      it { is_expected.to be true }
    end
  end
end

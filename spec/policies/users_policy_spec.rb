# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersPolicy do
  let(:policy) { UsersPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:User, target_user)) }
  let(:guest) { User.guest }
  let(:root) { build(:user, id: '1') }
  let(:user) { build(:user, id: '2') }
  let(:target_user) { build(:user, id: '3') }

  before do
    allow(root).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('1').and_return(root)
    allow(user).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('2').and_return(user)
    allow(target_user).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('3').and_return(target_user)
  end

  context 'current user is guest' do
    let(:current_user) { guest }

    describe '#edit?' do
      subject { policy.edit? }
      it { is_expected.to be false }
    end

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be false }
    end

    describe '#show?' do
      subject { policy.show? }
      it { is_expected.to be false }
    end

    describe '#update?' do
      subject { policy.update? }
      it { is_expected.to be false }
    end
  end

  context 'current user is root' do
    let(:current_user) { root }

    describe '#edit?' do
      subject { policy.edit? }
      it { is_expected.to be true }
    end

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be true }
    end

    describe '#show?' do
      subject { policy.show? }
      it { is_expected.to be true }
    end

    describe '#update?' do
      subject { policy.update? }
      it { is_expected.to be true }
    end
  end

  context 'current user is not target user' do
    let(:current_user) { user }

    describe '#edit?' do
      subject { policy.edit? }
      it { is_expected.to be false }
    end

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be true }
    end

    describe '#show?' do
      subject { policy.show? }
      it { is_expected.to be true }
    end

    describe '#update?' do
      subject { policy.update? }
      it { is_expected.to be false }
    end
  end

  context 'current user is target user' do
    let(:current_user) { target_user }

    describe '#edit?' do
      subject { policy.edit? }
      it { is_expected.to be true }
    end

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be true }
    end

    describe '#show?' do
      subject { policy.show? }
      it { is_expected.to be true }
    end

    describe '#update?' do
      subject { policy.update? }
      it { is_expected.to be true }
    end
  end
end

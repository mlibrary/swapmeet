# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :policy do
  let(:policy) { ApplicationPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(nil, nil)) }
  let(:guest) { User.guest }
  let(:root) { build(:user, id: '1') }
  let(:user) { build(:user, id: '2') }

  before do
    allow(root).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('1').and_return(root)
    allow(user).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('2').and_return(user)
  end

  context 'current user is guest' do
    let(:current_user) { guest }

    describe '#create?' do
      subject { policy.create? }
      it { is_expected.to be false }
    end

    describe '#destroy?' do
      subject { policy.destroy? }
      it { is_expected.to be false }
    end

    describe '#edit?' do
      subject { policy.edit? }
      it { is_expected.to be policy.update? }
    end

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be false }
    end

    describe '#new?' do
      subject { policy.new? }
      it { is_expected.to be policy.create? }
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

    describe '#create?' do
      subject { policy.create? }
      it { is_expected.to be true }
    end

    describe '#destroy?' do
      subject { policy.destroy? }
      it { is_expected.to be true }
    end

    describe '#edit?' do
      subject { policy.edit? }
      it { is_expected.to be true }
    end

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be true }
    end

    describe '#new?' do
      subject { policy.new? }
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

  context 'current user is user' do
    let(:current_user) { user }

    describe '#create?' do
      subject { policy.create? }
      it { is_expected.to be false }
    end

    describe '#destroy?' do
      subject { policy.destroy? }
      it { is_expected.to be false }
    end

    describe '#edit?' do
      subject { policy.edit? }
      it { is_expected.to be false }
    end

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be false }
    end

    describe '#new?' do
      subject { policy.new? }
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
end

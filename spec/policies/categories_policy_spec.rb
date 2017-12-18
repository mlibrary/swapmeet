# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesPolicy, type: :policy do
  it_should_behave_like 'application policy'

  let(:policy) { CategoriesPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Category, category)) }
  let(:guest) { User.guest }
  let(:root) { build(:user, id: '1') }
  let(:user) { build(:user, id: '2') }
  let(:category) { build(:category, id: '1') }

  before do
    allow(root).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('1').and_return(root)
    allow(user).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('2').and_return(user)
    allow(Category).to receive(:find).with('1').and_return(user)
    allow(category).to receive(:persisted?).and_return(true)
  end

  context 'current user is guest' do
    let(:current_user) { guest }

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be true }
    end
  end

  context 'current user is root' do
    let(:current_user) { root }

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be true }
    end
  end

  context 'current user is user' do
    let(:current_user) { user }

    describe '#index?' do
      subject { policy.index? }
      it { is_expected.to be true }
    end
  end
end

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

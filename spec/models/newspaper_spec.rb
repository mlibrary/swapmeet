# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Newspaper, type: :model do
  describe '#new' do
    context 'default' do
      subject { described_class.new }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Newspaper
        expect(subject.name).to be_nil
        expect(subject.display_name).to be_nil
        expect(subject.publisher_id).to be_nil
      end
    end
    context 'create' do
      subject { create(:newspaper, name: 'Name', display_name: 'Display Name') }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Newspaper
        expect(subject.name).to eq 'Name'
        expect(subject.display_name).to eq 'Display Name'
        expect(subject.publisher_id).not_to be_nil
      end
    end
  end

  xdescribe '#has_user?' do
    subject { newspaper.has_user?(user) }
    let(:newspaper) { described_class.new }
    let(:user) { double('user') }
    let(:users) { double('users') }
    let(:id) { double('id') }
    let(:boolean) { double('boolean') }
    before do
      allow(newspaper).to receive(:users).and_return(users)
      allow(user).to receive(:id).and_return(id)
      allow(users).to receive(:exists?).with(id).and_return(boolean)
    end
    it { is_expected.to be boolean }
  end
end

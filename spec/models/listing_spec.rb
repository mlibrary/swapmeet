# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe '#new' do
    context 'default' do
      subject { described_class.new }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Listing
        expect(subject.title).to be_nil
        expect(subject.body).to be_nil
        expect(subject.owner_id).to be_nil
        expect(subject.newspaper_id).to be_nil
        expect(subject.category_id).to be_nil
      end
    end
    context 'create' do
      subject { create(:listing, title: 'Title', body: 'Body') }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Listing
        expect(subject.title).to eq 'Title'
        expect(subject.body).to eq 'Body'
        expect(subject.owner_id).to be_nil
        expect(subject.newspaper_id).to be_nil
        expect(subject.category_id).not_to be_nil
      end
    end
  end

  describe '#owner' do
    subject { listing.owner }
    context 'nobody' do
      let(:listing) { create(:listing) }
      let(:nobody) { User.nobody }
      before { allow(User).to receive(:nobody).and_return(nobody) }
      it { is_expected.to be nobody }
    end
    context 'owner' do
      let(:listing) { create(:listing, owner: owner) }
      let(:owner) { create(:user) }
      it { is_expected.to be owner }
    end
  end
end

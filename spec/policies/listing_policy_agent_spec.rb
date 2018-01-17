# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingPolicyAgent do
  subject { listing_agent }

  let(:listing_agent) { described_class.new(listing) }
  let(:listing) { double('listing') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :Listing.to_s }
  it { expect(subject.client_id).to eq listing.to_s }
  it { expect(subject.client).to be listing }

  describe '#creator?' do
    subject { listing_agent.creator?(user) }

    let(:user) { double('user') }
    let(:owner) { double('owner') }

    before { allow(listing).to receive(:owner).and_return(owner) }

    it { is_expected.to be false }

    context 'owner' do
      let(:user) { owner }

      it { is_expected.to be true }
    end
  end
end

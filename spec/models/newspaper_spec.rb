require 'newspaper'
require 'ostruct'

RSpec.describe Newspaper do
  subject(:newspaper) { Newspaper.new }

  describe "#listings" do
    let(:listing_one) { OpenStruct.new }
    let(:listing_two) { OpenStruct.new }

    it "starts empty" do
      expect(newspaper.listings).to eq([])
    end

    it "keeps listings in order" do
      newspaper.add_listing(listing_one)
      newspaper.add_listing(listing_two)
      expect(newspaper.listings).to eq([listing_one, listing_two])
    end
  end

  describe "#new_listing" do
    let(:listing) { OpenStruct.new }
    let(:repo)    { double('Listing Repo', new: listing) }
    let(:newspaper)       { Newspaper.new(listing_repo: repo) }
    subject(:new_listing) { newspaper.new_listing }

    it "returns a new post" do
      expect(new_listing).to eq(listing)
    end

    it "sets the listing's newspaper reference to itself" do
      expect(new_listing.newspaper).to eq(newspaper)
    end
  end

  describe "#add_listing" do
    let(:listing) { OpenStruct.new }

    it "adds a listing" do
      newspaper.add_listing(listing)
      expect(newspaper.listings).to include(listing)
    end
  end
end

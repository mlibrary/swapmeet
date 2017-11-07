require 'newspaper'
require 'ostruct'

RSpec.describe Newspaper do
  subject(:newspaper) { Newspaper.new }
  let(:listings)      { [] }

  context "when not supplied listings" do
    it "has no listings" do
      expect(newspaper.listings).to match_array([])
    end
  end

  describe "#new_listing" do
    let(:listing) { OpenStruct.new }
    let(:repo)    { double('Listing Repo', new: listing) }
    subject(:newspaper) { Newspaper.new(listing_repo: repo) }

    it "returns a new post" do
      expect(newspaper.new_listing).to eq(listing)
    end

    it "sets the listing's newspaper reference to itself" do
      expect(newspaper.new_listing.newspaper).to eq(newspaper)
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

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

  context "when supplied listings" do
    subject(:newspaper) { Newspaper.new(listings) }
    let(:listings)      { [{title: 'Foo'}, {title: 'Bar'}] }

    it "retains them" do
      expect(newspaper.listings).to eq(listings)
    end
  end

  describe "#new_listing" do
    let(:listing) { OpenStruct.new }
    subject(:newspaper) {
      Newspaper.new.tap do |np|
        np.listing_repo = OpenStruct.new(new: listing)
      end
    }

    it "returns a new post" do
      expect(newspaper.new_listing).to eq(listing)
    end

    it "sets the listing's newspaper reference to itself" do
      expect(newspaper.new_listing.newspaper).to eq(newspaper)
    end
  end
end

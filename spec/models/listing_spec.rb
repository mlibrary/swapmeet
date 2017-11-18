require 'listing'

RSpec.describe Listing do
  subject(:listing) { Listing.new }

  describe "#new" do
    it "starts with blank attributes" do
      expect(listing.id)   .to be_nil
      expect(listing.title).to eq('')
      expect(listing.body) .to eq('')
    end
  end

  describe "#to_h" do
    subject(:hash) { listing.to_h }

    it "has all attributes" do
      expect(hash[:id]).to eq(nil)
      expect(hash[:title]).to eq('')
      expect(hash[:body]).to eq('')
    end
  end

  it "supports setting and reading the title" do
    listing.title = 'Onyx Chop Sticks'
    expect(listing.title).to eq('Onyx Chop Sticks')
  end

  it "has a body" do
    listing.body = 'A fine pair of chop sticks, made of pure onyx.'
    expect(listing.body).to eq('A fine pair of chop sticks, made of pure onyx.')
  end

  describe "#publish" do
    let(:newspaper) { instance_double('Newspaper') }

    it "can be published" do
      listing.newspaper = newspaper
      expect(newspaper).to receive(:add_listing).with(listing)
      listing.publish
    end
  end
end

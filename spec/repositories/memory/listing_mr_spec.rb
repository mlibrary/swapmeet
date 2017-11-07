require 'memory/listing_mr'

RSpec.describe MemoryRepository::Listing do
  subject(:repo) { MemoryRepository::Listing.new }

  it "returns a new Listing" do
    expect(repo.new).to_not be_nil
  end

  describe "#save" do
    let(:listing) { repo.new }
    before(:each) do
      repo.save(listing)
    end

    it "assigns an id on save" do
      expect(listing.id).to_not be_nil
    end

    it "adds the listing" do
      expect(repo.all).to include(listing)
    end
  end
end

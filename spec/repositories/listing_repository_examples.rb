RSpec.shared_examples "Listing Repository" do
  subject(:repo) { described_class.new }

  it "returns a new Listing" do
    expect(repo.new).to_not be_nil
  end

  it "can find saved listings" do
    listing = repo.new
    repo.save(listing)
    other = repo.find(listing.id)
    expect(other).to eq(listing)
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

    it "supports updates" do
      listing.title = 'title'
      listing.body = 'body'
      repo.save(listing)
      other = repo.find(listing.id)
      expect(other).to eq(listing)
    end
  end
end

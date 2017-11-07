require 'memory/listing_mr'

RSpec.describe MemoryRepository::Listing do
  subject(:repo) { MemoryRepository::Listing.new }

  it do
    listing = repo.new
    listing.title
    repo.save(listing)
    expect(listing.id).to_not be_nil
  end
end

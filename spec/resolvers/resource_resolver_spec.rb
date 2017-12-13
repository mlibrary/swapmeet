require 'resource_resolver'

RSpec.describe ResourceResolver do
  let(:listing1) { double('Listing', id: 12, entity_type: 'listing') }
  let(:listing2) { double('Listing', id: 13, entity_type: 'listing') }
  let(:newspaper) { double('Newspaper', id: 8, entity_type: 'newspaper') }

  it "resolves a listing to its entity token" do
    resolver = ResourceResolver.new(listing1)
    expect(resolver.resolve).to include('listing:12')
  end

  it "resolves another listing to its entity token" do
    resolver = ResourceResolver.new(listing2)
    expect(resolver.resolve).to include('listing:13')
  end

  it "resolves a listing to its type token" do
    resolver = ResourceResolver.new(listing1)
    expect(resolver.resolve).to include('type:listing')
  end

  it "resolves a newspaper to its entity token" do
    resolver = ResourceResolver.new(newspaper)
    expect(resolver.resolve).to include('newspaper:8')
  end

  it "resolves a newspaper to its type token" do
    resolver = ResourceResolver.new(newspaper)
    expect(resolver.resolve).to include('type:newspaper')
  end

end

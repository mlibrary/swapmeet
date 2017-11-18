require 'memory/listing_repository'
require_relative '../listing_repository_examples'

RSpec.describe MemoryRepository::ListingRepository do
  include_examples "Listing Repository"
end

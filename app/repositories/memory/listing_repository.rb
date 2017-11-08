require_relative '../memory'
require 'listing'
module MemoryRepository
  class ListingRepository
    def initialize
      @records = {}
      @id = 1
    end

    def new
      Listing.new
    end

    def all
      @records.values.to_a
    end
    
    def save(listing)
      listing.id = @id
      @records[@id] = listing
      @id += 1
      listing
    end
  end
end

MemoryRepository.register(:listing, MemoryRepository::ListingRepository.new)

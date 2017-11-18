require_relative '../memory_repository'
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

    def find(id)
      @records[id]
    end

    def all
      @records.values.to_a
    end
    
    def save(listing)
      if listing.id.nil?
        create(listing)
      else
        update(listing)
      end
    end

    private

    def create(listing)
      listing.id = @id
      @records[@id] = listing
      @id += 1
      listing
    end

    def update(listing)
      @records[listing.id] = listing
    end
  end
end

MemoryRepository.register(:listing, MemoryRepository::ListingRepository.new)

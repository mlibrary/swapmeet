require 'ostruct'
require_relative '../memory'
module MemoryRepository
  class Listing
    def initialize
      @records = {}
      @id = 1
    end

    def new
      OpenStruct.new title: 'A title'
    end
    
    def save(listing)
      listing.id = @id
      @records[@id] = listing
      @id += 1
      listing
    end
  end
end

MemoryRepository.register(:listing, MemoryRepository::Listing)

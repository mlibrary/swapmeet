require_relative '../ar_repository'
require 'listing'

module ActiveRecordRepository
  class ListingRepository
    def new
      Listing.new
    end

    def find(id)
      ArListing.find(id).to_listing
    end

    def save(listing)
      if listing.id.nil?
        create(listing)
      else
        update(listing)
      end
    end

    def all
      ArListing.all.map(&:to_listing)
    end

    private

    def create(listing)
      resource = ArListing.create(listing.to_h)
      resource.save
      listing.id = resource.id
      listing
    end

    def update(listing)
      resource = ArListing.find(listing.id)
      resource.update_attributes(listing.to_h)
      listing
    end
  end

  class ArListing < ApplicationRecord
    self.table_name = 'listings'

    def to_listing
      Listing.new.tap do |listing|
        listing.id = id
        listing.title = title
        listing.body = body
      end
    end
  end
end

ActiveRecordRepository.register(:listing, ActiveRecordRepository::ListingRepository.new)

class Newspaper
  attr_reader :listings
  attr_writer :listing_repo

  def initialize(listings = [])
    @listings = listings
  end

  def new_listing
    listing_repo.new.tap do |listing|
      listing.newspaper = self
    end
  end

  private
  def listing_repo
    @listing_repo ||= Repository.for(:listing)
  end
end

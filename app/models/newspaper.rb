class Newspaper
  def initialize(listing_repo: Repository.for(:listing))
    @listing_repo = listing_repo
  end

  def new_listing
    listing_repo.new.tap do |listing|
      listing.newspaper = self
    end
  end

  def add_listing(listing)
    listing_repo.save(listing)
  end

  def listings
    listing_repo.all
  end

  private
  attr_reader :listing_repo
end

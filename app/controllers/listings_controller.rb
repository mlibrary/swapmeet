class ListingsController < ApplicationController
  def index
    render locals: { listings: Listing.all }
  end

  def new
    render locals: { listing: Listing.new }
  end

  def create
    listing = Listing.new(listing_params)
    if listing.save
      redirect_to listings_path
    else
      render :new, locals: { listing: listing }
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :body)
  end
end

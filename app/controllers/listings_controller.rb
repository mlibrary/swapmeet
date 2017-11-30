class ListingsController < ApplicationController
  def index
    render locals: { listings: Listing.all }
  end

  def show
    listing = find_listing
    render locals: { listing: listing }
  end

  def new
    render locals: { listing: Listing.new }
  end

  def edit
    listing = find_listing
    render locals: { listing: listing }
  end

  def create
    listing = Listing.new(listing_params)
    if listing.save
      redirect_to listings_path
    else
      render :new, locals: { listing: listing }
    end
  end

  def update
    listing = find_listing
    if listing.update(listing_params)
      redirect_to listing
    else
      render :edit, locals: { listing: listing }
    end
  end

  private

  def find_listing
    Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :body)
  end
end

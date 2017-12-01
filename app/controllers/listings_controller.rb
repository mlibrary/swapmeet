class ListingsController < ApplicationController
  def index
    render with(listings: Listing.all)
  end

  def show
    policy(listing).authorize! :show?
    render with_listing
  end

  def new
    @listing = Listing.new
    render with_listing
  end

  def edit
    render with_listing
  end

  def create
    @listing = Listing.new(listing_params)
    listing.owner = current_user
    if listing.save
      redirect_to listings_path
    else
      render :new, with_listing
    end
  end

  def update
    if listing.update(listing_params)
      redirect_to listing
    else
      render :edit, with_listing
    end
  end

  def destroy
    policy(listing).authorize! :destroy?
    listing.destroy
    redirect_to listings_url
  end

  private

  def policy(listing = nil)
    ListingPolicy.new(current_user, listing)
  end

  def with(locals = {})
    { locals: locals }
  end

  def with_listing
    { locals: { listing: listing } }
  end

  def listing
    @listing ||= Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :body)
  end
end

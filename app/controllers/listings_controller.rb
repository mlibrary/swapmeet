class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :create, :update, :destroy]
  before_action :set_policy, only: [:show, :edit, :create, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def show
    @policy.authorize! :show?
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    if @listing.save
      redirect_to listings_path
    else
      render :new
    end
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    @policy.authorize! :destroy?
    @listing.destroy
    redirect_to listings_url
  end

  private

  def set_listing
    @listing ||= Listing.find(params[:id])
  end

  def set_policy
    @policy = ListingPolicy.new(current_user, @listing)
  end

  def listing_params
    params.require(:listing).permit(:title, :body)
  end
end

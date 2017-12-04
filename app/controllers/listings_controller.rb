class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_policy, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  def index
    return render_unauthorized unless @policy.authorize! :index?
    @listings = Listing.all
  end

  def show
    return render_unauthorized unless @policy.authorize! :show?
  end

  def new
    return render_unauthorized unless @policy.authorize! :new?
    @listing = Listing.new
  end

  def edit
    return render_unauthorized unless @policy.authorize! :edit?
  end

  def create
    return render_unauthorized unless @policy.authorize! :create?
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    if @listing.save
      redirect_to listings_path
    else
      render :new
    end
  end

  def update
    return render_unauthorized unless @policy.authorize! :update?
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    return render_unauthorized unless @policy.authorize! :destroy?
    @listing.destroy
    redirect_to listings_path
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

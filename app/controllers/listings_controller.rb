# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_policy #, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  def index
    @policy.authorize! :index?
    @listings = Listing.all
  end

  def show
    @policy.authorize! :show?
  end

  def new
    @policy.authorize! :new?
    @listing = Listing.new
  end

  def edit
    @policy.authorize! :edit?
  end

  def create
    @policy.authorize! :create?
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    if @listing.save
      redirect_to listings_path
    else
      render :new
    end
  end

  def update
    @policy.authorize! :update?
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    @policy.authorize! :destroy?
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

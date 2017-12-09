# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_policy #, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  def create
    @policy.authorize! :create?
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @policy.authorize! :destroy?
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
    @policy.authorize! :edit?
  end

  def index
    @policy.authorize! :index?
    @listings = Listing.all
  end

  def new
    @policy.authorize! :new?
    @listing = Listing.new
  end

  def show
    @policy.authorize! :show?
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
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

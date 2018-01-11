# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    @policy.authorize! :index?
    @filter = Filter.new
    @newspapers = Newspaper.all
    @owners = User.all
    @categories = Category.all

    if params[:f].present?
      @filter.newspaper = params[:f][:newspaper]
      @filter.owner = params[:f][:owner]
      @filter.category = params[:f][:category]
      template = []
      values = []
      if @filter.newspaper.present?
        template << "newspaper_id = ?"
        values << @filter.newspaper
      end
      if @filter.owner.present?
        template << "owner_id = ?"
        values << @filter.owner
      end
      if @filter.category.present?
        template << "category_id = ?"
        values << @filter.category
      end
      @listings = Listing.where(template.join(" AND "), *values) if values.any?
    end

    @listings ||= Listing.all
  end

  def show
    @policy.authorize! :show?, @listing
  end

  def new
    if params[:newspaper_id].present?
      @newspaper = Newspaper.find(params[:newspaper_id])
      @policy.authorize! :new?, @newspaper
      @listing = Listing.new
    else
      @policy.authorize! :new?
      @listing = Listing.new
    end
  end

  def edit
    @policy.authorize! :edit?, @listing
  end

  def create
    @newspaper = Newspaper.find(listing_params[:newspaper_id]) if listing_params[:newspaper_id].present?
    @policy.authorize! :create?, @newspaper
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

  def update
    @policy.authorize! :update?, @listing
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

  def destroy
    @policy.authorize! :destroy?, @listing
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Authorization Policy
    def new_policy
      ListingPolicy.new(SubjectPolicyAgent.new(:User, current_user), ObjectPolicyAgent.new(:Listing, @listing))
    end

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:category_id, :title, :body, :newspaper_id)
    end
end

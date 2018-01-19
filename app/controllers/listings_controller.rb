# frozen_string_literal: true

class ListingsController < ApplicationController
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
    @listings = @listings.map { |listing| ListingPresenter.new(current_user, @policy, listing) }
  end

  def show
    @policy.authorize! :show?
    @listing = ListingPresenter.new(current_user, @policy, @listing)
  end

  def new
    @newspaper = Newspaper.find(params[:newspaper_id]) if params[:newspaper_id].present?
    @policy.authorize! :new?
    @listing = Listing.new
    # @listing = ListingPresenter.new(current_user, @policy, @listing)
  end

  def edit
    @newspaper = Newspaper.find(params[:newspaper_id]) if params[:newspaper_id].present?
    @policy.authorize! :edit?
    # @listing = ListingPresenter.new(current_user, @policy, @listing)
  end

  def create
    @newspaper = Newspaper.find(listing_params[:newspaper_id]) if listing_params[:newspaper_id].present?
    @policy.authorize! :create?
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html do
          # @listing = ListingPresenter.new(current_user, @policy, @listing)
          render :new
        end
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html do
          # @listing = ListingPresenter.new(current_user, @policy, @listing)
          render :edit
        end
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

  private
    # Authorization Policy
    def new_policy
      @listing = Listing.find(params[:id]) if params[:id].present?
      ListingPolicy.new(UserPolicyAgent.new(current_user), ListingPolicyAgent.new(@listing))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:category_id, :title, :body, :newspaper_id)
    end
end

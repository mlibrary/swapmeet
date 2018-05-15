# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_policy, except: [:index, :new]

  def create
    @policy.authorize! :create?
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    respond_to do |format|
      if save_listing
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, errors: @listing.errors  }
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
    policy = ListingsPolicy.new(current_user)
    # @listings = ListingsPresenter.new(policy, view_context)
    @listings = present(policy.base_scope)
  end

  def new
    @policy = ListingsPolicy.new(current_user)
    @policy.authorize! :new?
    @listing = Listing.new
  end

  def show
    @policy.authorize! :show?
    # @listing = ListingPresenter.new(@policy, view_context)
    @listing = present(@policy.resource)
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if update_listing 
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, errors: @listing.errors  }
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
      params.require(:listing).permit(:title, :body, :category_id)
    end

    def handle_image
      image = params[:listing][:image]
      return true unless image
      unless %w(image/png image/gif image/jpeg).include?(image.content_type)
        @listing.errors.add(:image, "must be a gif, jpeg, or png")
        return false
      end

      @listing.add_image!(image.tempfile.path) if image
      return true
    end


    def save_listing
      handle_image && @listing.save
    end

    def update_listing
      handle_image && @listing.update(listing_params)
    end
end

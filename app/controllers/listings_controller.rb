class ListingsController < ApplicationController
  def index
    render locals: { listings: newspaper.listings }
  end

  def new
    render locals: { listing: newspaper.new_listing }
  end

  def create
    l = newspaper.new_listing
    listing_params.tap do |p|
      l.title = p[:title]
      l.body = p[:body]
    end
    newspaper.add_listing(l)
    redirect_to listings_path
  end

  def listing_params
    params.permit(:title, :body)
  end
end

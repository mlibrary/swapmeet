class ListingPresenter < SimpleDelegator
  attr_reader :listing, :policy

  def initialize(listing, policy, view_context)
    @listing      = listing
    @policy       = policy
    @view_context = view_context
    __setobj__ @listing
  end

  def link_or_title
    if policy.show?
      h.link_to title, listing
    else
      title
    end
  end

  def show_link
    h.link_to 'Show', listing if policy.show?
  end

  def edit_link
    if policy.edit?
      h.link_to 'Edit', h.edit_listing_path(listing)
    end
  end

  private

  attr_reader :view_context
  alias_method :h, :view_context
end

# class ListingsPresenter
#   attr_reader :policy, :view_context
#
#   def initialize(listings, policy, view_context)
#     @listings     = listings
#     @policy       = policy
#     @view_context = view_context
#   end
#
#   def listings
#     @listings.map {|listing| ListingPresenter.new(listing, policy.for(listing)) }
#   end
# end


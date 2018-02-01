# frozen_string_literal: true

class ListingPresenter < SimpleDelegator
  extend Forwardable

  delegate [:edit?, :destroy?] => :policy

  def initialize(listing, policy, view)
    @listing = listing
    @policy  = policy
    @view    = view
    __setobj__ @listing
  end

  def link_or_title
    if policy.show?
      view.link_to title, listing
    else
      title
    end
  end

  def show_link
    view.link_to 'Show', listing if policy.show?
  end

  private

    attr_reader :listing, :policy, :view
end

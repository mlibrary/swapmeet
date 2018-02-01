# frozen_string_literal: true

class ListingsPolicy < CollectionPolicy
  def base_scope
    Listing.all
  end

  def new?
    user.known?
  end
end


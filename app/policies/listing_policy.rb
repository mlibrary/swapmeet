# frozen_string_literal: true

# Sample resource-oriented, multi-rule policy
class ListingPolicy
  attr_reader :user, :listing

  def initialize(user, listing)
    @user = user
    @listing = listing
  end

  def create?
    user.known?
  end

  def edit?
    listing.owner == user
  end

  def destroy?
    listing.owner == user
  end

  def index?
    true
  end

  def new?
    user.known?
  end

  def show?
    true
  end

  def update?
    listing.owner == user
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
    true
  end
end

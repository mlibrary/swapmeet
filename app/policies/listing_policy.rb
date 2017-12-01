# Sample resource-oriented, multi-rule policy
class ListingPolicy
  attr_reader :user, :listing

  def initialize(user, listing)
    @user = user
    @listing = listing
  end

  def show?
    true
  end

  def destroy?
    # Rely on owner returning Nobody rather than nil
    listing.owner == user
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

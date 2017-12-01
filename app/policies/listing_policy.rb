# Sample resource-oriented, multi-rule policy
class ListingPolicy
  def initialize(user, listing)
    @user = user
    @listing = listing
  end

  def show?
    true
  end

  def destroy?
    true
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

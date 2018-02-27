# frozen_string_literal: true

class ListingPolicy < ResourcePolicy
  def show?
    true
  end

  def create?
    return true if user.has_role?(:admin)
    user.known?
  end

  def update?
    return true if user.has_role?(:admin)
    user == resource.owner
  end

  def destroy?
    return true if user.has_role?(:admin)
    user == resource.owner
  end
end

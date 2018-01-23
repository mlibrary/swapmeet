# frozen_string_literal: true

class ListingPolicy < ResourcePolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    return true if subject.root?
    subject.known?
  end

  def update?
    return true if subject.root?
    subject == object.owner
  end

  def destroy?
    return true if subject.root?
    subject == object.owner
  end

end

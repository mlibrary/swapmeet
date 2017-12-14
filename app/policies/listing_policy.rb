# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  def create?
    return true if subject.root?
    subject.known?
  end

  def destroy?(listing = nil)
    return true if subject.root?
    subject.client == object.client&.owner
  end

  def index?
    true
  end

  def show?(listing = nil)
    true
  end

  def update?(listing = nil)
    return true if subject.root?
    subject.client == object.client&.owner
  end
end

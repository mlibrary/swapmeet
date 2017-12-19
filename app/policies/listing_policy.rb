# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  def create?
    subject.known?
  end

  def destroy?(listing = nil)
    subject.client == object.client&.owner
  end

  def index?
    true
  end

  def show?(listing = nil)
    true
  end

  def update?(listing = nil)
    subject.client == object.client&.owner
  end
end

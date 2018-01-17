# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  def index?
    return false unless @subject.client_type == :User.to_s
    true
  end

  def show?
    return false unless @subject.client_type == :User.to_s
    true
  end

  def create?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    true
  end

  def update?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @object.creator?(@subject.client)
    PolicyResolver.new(subject, ActionPolicyAgent.new(:update), object).grant?
  end

  def destroy?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @object.creator?(@subject.client)
    PolicyResolver.new(subject, ActionPolicyAgent.new(:destroy), object).grant?
  end

  def edit_listing?(listing)
    ListingPolicy.new(@subject, ListingPolicyAgent.new(listing)).edit?
  end

  def destroy_listing?(listing)
    ListingPolicy.new(@subject, ListingPolicyAgent.new(listing)).destroy?
  end
end

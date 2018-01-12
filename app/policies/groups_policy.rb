# frozen_string_literal: true

class GroupsPolicy < ApplicationPolicy
  def index?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    true
  end

  def show?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    true
  end

  def add?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    PolicyResolver.new(subject, ActionPolicyAgent.new(:update), object).grant?
  end

  def remove?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    PolicyResolver.new(subject, ActionPolicyAgent.new(:update), object).grant?
  end
end

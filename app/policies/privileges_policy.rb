# frozen_string_literal: true

class PrivilegesPolicy < ApplicationPolicy
  def permit?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    PolicyResolver.new(subject, ActionPolicyAgent.new(:permit), object).grant?
  end

  def revoke?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    PolicyResolver.new(subject, ActionPolicyAgent.new(:revoke), object).grant?
  end
end

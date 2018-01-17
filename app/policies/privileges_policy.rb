# frozen_string_literal: true

class PrivilegesPolicy < ApplicationPolicy
  def permit?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :permit), object).grant?
  end

  def revoke?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :revoke), object).grant?
  end
end

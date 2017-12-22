# frozen_string_literal: true

class PrivilegesPolicy < ApplicationPolicy
  def permit?
    return false unless subject.known?
    return true if subject.application_administrator?
    return true if subject.platform_administrator?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :permit), object).grant?
  end

  def revoke?
    return false unless subject.known?
    return true if subject.application_administrator?
    return true if subject.platform_administrator?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :revoke), object).grant?
  end
end

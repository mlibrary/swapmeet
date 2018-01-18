# frozen_string_literal: true

class RootPolicy < ApplicationPolicy
  def administrator_user?(user)
    PolicyMaker.new(@subject).exist?(UserPolicyAgent.new(user), RolePolicyAgent.new(:administrator), PolicyMaker::OBJECT_ANY)
  end

  def method_missing(method_name, *args, &block)
    return true if method_name[-1] == '?'
    super
  end
end

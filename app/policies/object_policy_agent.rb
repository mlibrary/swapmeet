# frozen_string_literal: true

class ObjectPolicyAgent < PolicyAgent
  def administrator?(user)
    policy_resolver = PolicyResolver.new(
      UserPolicyAgent.new(user),
      RolePolicyAgent.new(:administrator),
      self
    )
    policy_resolver.grant?
  end
end

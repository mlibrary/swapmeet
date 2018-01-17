# frozen_string_literal: true

class PolicyPolicyAgent < VerbPolicyAgent
  def initialize(policy)
    super(:Policy, policy)
  end
end

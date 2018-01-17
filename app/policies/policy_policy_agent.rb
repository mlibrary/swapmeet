# frozen_string_literal: true

class PolicyPolicyAgent < VerbPolicyAgent
  def initialize(client)
    super(:Policy, client)
  end
end

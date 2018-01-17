# frozen_string_literal: true

class RolePolicyAgent < VerbPolicyAgent
  def initialize(role)
    super(:Role, role)
  end
end

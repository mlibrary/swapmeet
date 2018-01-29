# frozen_string_literal: true

class PrivilegePolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:Privilege, client)
  end
end

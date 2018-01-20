# frozen_string_literal: true

class GroupPolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:Group, client)
  end
end

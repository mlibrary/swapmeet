# frozen_string_literal: true

class DomainPolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:Domain, client)
  end
end

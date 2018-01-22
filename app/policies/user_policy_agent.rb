# frozen_string_literal: true

class UserPolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:User, client)
  end
end

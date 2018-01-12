# frozen_string_literal: true

class ActionPolicyAgent < VerbPolicyAgent
  def initialize(client)
    super(:Action, client)
  end
end

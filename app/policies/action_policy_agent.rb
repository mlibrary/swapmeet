# frozen_string_literal: true

class ActionPolicyAgent < VerbPolicyAgent
  def initialize(action)
    super(:Action, action)
  end
end

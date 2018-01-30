# frozen_string_literal: true

class NounPolicyAgent < PolicyAgent
  def administrator?
    PolicyMaker.exists?(self, RolePolicyAgent.new(:administrator), PolicyMaker::OBJECT_ANY)
  end
end

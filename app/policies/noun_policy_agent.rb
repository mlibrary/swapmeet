# frozen_string_literal: true

class NounPolicyAgent < PolicyAgent
  def administrator?
    PolicyMaker.exist?(self, RolePolicyAgent.new(:administrator), PolicyMaker::OBJECT_ANY)
  end
end

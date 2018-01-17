# frozen_string_literal: true

class SubjectPolicyAgent < PolicyAgent
  def administrator?
    PolicyMaker.new(@subject).exist?(self, RolePolicyAgent.new(:administrator), PolicyMaker::OBJECT_ANY)
  end
end

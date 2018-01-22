# frozen_string_literal: true

class NounPolicyAgent < PolicyAgent
  def administrator?
    PolicyMaker.new(self).exist?(self, RolePolicyAgent.new(:administrator), PolicyMaker::OBJECT_ANY)
  end

  # def fly?(user)
  #   PolicyResolver.new(SubjectPolicyAgent.new(:User, user), RolePolicyAgent.new(:administrator),self).grant?
  # end
end

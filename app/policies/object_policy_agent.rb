# frozen_string_literal: true

class ObjectPolicyAgent < PolicyAgent
  def owner
    client.owner if client&.respond_to?(:owner)
  end
end

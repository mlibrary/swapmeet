# frozen_string_literal: true

class PublisherPolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:Publisher, client)
  end
end

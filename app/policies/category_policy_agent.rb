# frozen_string_literal: true

class CategoryPolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:Category, client)
  end
end

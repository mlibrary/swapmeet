# frozen_string_literal: true

class NewspaperPolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:Newspaper, client)
  end
end

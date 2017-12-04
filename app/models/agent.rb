# frozen_string_literal: true

class Agent
  attr_reader :owner

  def initialize(user)
    @owner = user
  end

  delegate :id, to: :@owner
end

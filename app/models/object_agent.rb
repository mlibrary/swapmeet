# frozen_string_literal: true

class ObjectAgent
  attr_reader :object

  def initialize(object)
    @object = object
  end

  delegate :id, to: :@object
end

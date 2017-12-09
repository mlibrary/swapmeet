# frozen_string_literal: true

class PolicyAgent
  attr_reader :client_type
  attr_reader :client

  def initialize(client_type, client)
    @client_type
    @client
  end

  def known?
    client&.persisted?
  end
end

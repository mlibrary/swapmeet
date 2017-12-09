# frozen_string_literal: true

class PolicyAgent
  attr_reader :client_type
  attr_reader :client

  def initialize(client_type, client)
    @client_type = client_type
    @client = client
  end

  def known?
    return false if client&.persisted? == nil
    client&.persisted?
  end

  def root?
    return false unless client_type == :User
    return false unless known?
    return false unless client&.id == 1
    true
  end
end

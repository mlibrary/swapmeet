# frozen_string_literal: true

class PolicyAgent
  attr_reader :client_type
  attr_reader :client

  def initialize(client_type, client)
    @client_type = client_type
    @client = client
  end

  def client_type
    @client_type.to_s
  end

  def client_id
    return client&.id if client&.respond_to?(:id)
    client&.to_s
  end

  def client_persisted?
    return client&.persisted? if client&.respond_to?(:persisted?)
    false
  end
end

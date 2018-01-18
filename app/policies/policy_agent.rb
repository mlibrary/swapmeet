# frozen_string_literal: true

class PolicyAgent
  def initialize(client_type, client)
    @client_type = client_type
    @client = client
  end

  def client
    @client
  end

  def client_id
    return nil if @client.nil?
    return @client&.id.to_s if @client&.respond_to?(:id)
    @client&.to_s
  end

  def client_type
    return nil if @client_type.nil?
    @client_type.to_s
  end
end

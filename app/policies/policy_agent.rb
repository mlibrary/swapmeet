# frozen_string_literal: true

class PolicyAgent
  attr_reader :client_type
  attr_reader :client

  def initialize(client_type, client)
    @client_type = client_type
    @client = client
  end

  def known?
    client_persisted?
  end

  def owner
    client.owner if client&.respond_to?(:owner)
  end

  def application_administrator?
    return true if Rails.application.config.administrators[:application].include?(client_email)
    false
  end

  def platform_administrator?
    return true if Rails.application.config.administrators[:platform].include?(client_email)
    false
  end

  private

    def client_persisted?
      return false if client&.persisted? == nil
      client.persisted?
    end

    def client_email
      client.email if client&.respond_to?(:email)
    end
end

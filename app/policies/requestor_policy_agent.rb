# frozen_string_literal: true

class RequestorPolicyAgent < PolicyAgent
  def user?
    return false unless client_type == :User.to_s
    client_persisted?
  end

  def known?
    client_persisted?
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

    def client_email
      client.email if client&.respond_to?(:email)
    end
end

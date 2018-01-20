# frozen_string_literal: true

class SubjectPolicyAgent < NounPolicyAgent
  def anonymous?
    !authenticated?
  end

  def authenticated?
    return false unless client_type == :User.to_s
    return false unless client.present?
    client.known?
  end
end

# frozen_string_literal: true

class UserPolicyAgent < SubjectPolicyAgent
  def initialize(client)
    super(:User, client)
  end

  def anonymous?
    !authenticated?
  end

  def authenticated?
    @client.known?
  end
end

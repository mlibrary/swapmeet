# frozen_string_literal: true

class PublisherUserPrivilegesPolicy < PublisherUsersPolicy
  attr_reader :user_agent

  def initialize(agents)
    super(agents)
    @user_agent = agents[2]
  end

  def permit?
    return false unless subject_agent.client_type == :User.to_s
    return false unless subject_agent.authenticated?
    return true if subject_agent.administrator?
    PolicyResolver.new(subject_agent, ActionPolicyAgent.new(:permit), object_agent).grant?
  end

  def revoke?
    return false unless subject_agent.client_type == :User.to_s
    return false unless subject_agent.authenticated?
    return true if subject_agent.administrator?
    PolicyResolver.new(subject_agent, ActionPolicyAgent.new(:revoke), object_agent).grant?
  end
end

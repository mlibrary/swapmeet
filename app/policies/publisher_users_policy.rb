# frozen_string_literal: true

class PublisherUsersPolicy < ApplicationPolicy
  attr_reader :publisher_agent

  def initialize(agents)
    super(agents)
    @publisher_agent = agents[1]
  end

  def index?
    return true if subject_agent.administrator?
    return false unless subject_agent.client_type == :User.to_s
    return false unless subject_agent.authenticated?
    return false unless object_agent.client_type == :Publisher.to_s
    return false unless object_agent.client_id.present?
    # object_agent.client.users.exists?(subject_agent.client_id)
    publisher_agent.client.users.exists?(subject_agent.client_id) if publisher_agent.client.present?
  end

  def privilege?
    # if object.present?
    #   PolicyMaker.exists?(policy.object, PolicyMaker::ROLE_ADMINISTRATOR, object.policy.object)
    # else
    #   PolicyMaker.exists?(policy.object, PolicyMaker::ROLE_ADMINISTRATOR, PolicyMaker::OBJECT_ANY)
    # end
    PolicyMaker.exists?(object_agent, PolicyMaker::ROLE_ADMINISTRATOR, publisher_agent)
  end
end

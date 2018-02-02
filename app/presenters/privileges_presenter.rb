# frozen_string_literal: true

class PrivilegesPresenter < ApplicationsPresenter
  def initialize(user, policy, privileges)
    # presenters = privileges.select { |p| p.subject_id == policy.object_agent.client_id }.map do |privilege|
    presenters = privileges.map do |privilege|
      agents = policy.agents.dup
      agents[-1] = PrivilegePolicyAgent.new(privilege)
      PrivilegePresenter.new(user, PrivilegesPolicy.new(agents), privilege)
    end
    super(user, policy, privileges, presenters)
  end
end

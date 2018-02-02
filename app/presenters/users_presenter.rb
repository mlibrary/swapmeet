# frozen_string_literal: true

class UsersPresenter < ApplicationsPresenter
  def initialize(user, policy, users)
    presenters = users.map do |usr|
      agents = policy.agents.dup
      agents[-1] = UserPolicyAgent.new(usr)
      UserPresenter.new(user, UsersPolicy.new(agents), usr)
    end
    super(user, policy, users, presenters)
  end
end

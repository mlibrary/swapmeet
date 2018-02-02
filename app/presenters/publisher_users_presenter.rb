# frozen_string_literal: true

class PublisherUsersPresenter < ApplicationsPresenter
  def initialize(user, publisher_users_policy, users)
    presenters = users.map do |usr|
      PublisherUserPresenter.new(user, PublisherUsersPolicy.new([publisher_users_policy.subject_agent, publisher_users_policy.publisher_agent, UserPolicyAgent.new(usr)]), usr)
    end
    super(user, publisher_users_policy, users, presenters)
  end
end

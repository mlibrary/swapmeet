# frozen_string_literal: true

class NewspaperPresenter < ApplicationPresenter
  def administrator?(user)
    policy.administrator?(user.policy.object)
  end

  def permit?(user)
    policy.revoke?(user.policy.object)
  end

  def revoke?(user)
    policy.revoke?(user.policy.object)
  end

  def label
    return display_name if display_name.present?
    'NEWSPAPER'
  end

  delegate :name, :display_name, to: :model

  def publisher
    PublisherPresenter.new(user,
                           PublishersPolicy.new(policy.subject, PublisherPolicyAgent.new(model.publisher)),
                           model.publisher)
  end

  def listings
    ListingsPresenter.new(user, ListingPolicy.new(policy.subject, policy.object), model.listings)
  end

  def groups
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.groups)
  end

  def users
    UsersPresenter.new(user, UsersPolicy.new(policy.subject, policy.object), model.users)
  end
end

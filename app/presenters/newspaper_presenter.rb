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
                           PublishersPolicy.new(policy.subject,
                                                PublisherPolicyAgent.new(model.publisher)),
                           model.publisher)
  end

  def listings
    model.listings.map do |listing|
      ListingPresenter.new(user, ListingPolicy.new(policy.subject,
                                                   ListingPolicyAgent.new(listing)),
                           listing)
    end
  end

  def groups
    model.groups.map do |group|
      GroupPresenter.new(user, GroupsPolicy.new(policy.subject,
                                                GroupPolicyAgent.new(group)),
                         group)
    end
  end

  def users
    model.users.map do |usr|
      UserPresenter.new(user, UsersPolicy.new(policy.subject,
                                               UserPolicyAgent.new(usr)),
                        usr)
    end
  end

  def has_user?(user)
    model.has_user?(user.model)
  end
end

# frozen_string_literal: true

class UserPresenter < ApplicationPresenter
  def join?(object)
    policy.leave?(object.policy.object)
  end

  def leave?(object)
    policy.leave?(object.policy.object)
  end

  def add?(object)
    policy.add?(object.policy.object)
  end

  def remove?(object)
    policy.remove?(object.policy.object)
  end

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
    'USER'
  end

  delegate :username, :display_name, :email, to: :model

  def listings
    model.listings.map do |listing|
      ListingPresenter.new(user, ListingPolicy.new(policy.subject,
                                                   ListingPolicyAgent.new(listing)),
                           listing)
    end
  end

  def publishers
    model.publishers.map do |publisher|
      PublisherPresenter.new(user, PublishersPolicy.new(policy.subject,
                                                        PublisherPolicyAgent.new(publisher)),
                             publisher)
    end
  end

  def newspapers
    model.newspapers.map do |newspaper|
      NewspaperPresenter.new(user, NewspapersPolicy.new(policy.subject,
                                                        NewspaperPolicyAgent.new(newspaper)),
                             newspaper)
    end
  end

  def groups
    model.groups.map do |group|
      GroupPresenter.new(user, GroupsPolicy.new(policy.subject,
                                                GroupPolicyAgent.new(group)),
                         group)
    end
  end
end

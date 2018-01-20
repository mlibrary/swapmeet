# frozen_string_literal: true

class UserPresenter < ApplicationPresenter
  def administrator?
    policy.object.administrator?
  end

  def permit?
    return true if policy.subject.administrator?
    #   PrivilegesPolicy.new(@subject, UserPolicyAgent.new(user)).permit?
    false
  end

  def revoke?
    return true if policy.subject.administrator?
    #   PrivilegesPolicy.new(@subject, UserPolicyAgent.new(user)).revoke?
    false
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

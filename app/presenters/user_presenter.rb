# frozen_string_literal: true

class UserPresenter < ApplicationPresenter
  def label
    return display_name if display_name.present?
    'USER'
  end

  delegate :administrator?, :permit?, :revoke?, to: :policy

  # def permit?
  #   return true if policy.subject.administrator?
  #   PrivilegesPolicy.new(policy.subject, policy.object).permit?
  # end
  #
  # def revoke?
  #   return true if policy.subject.administrator?
  #   PrivilegesPolicy.new(policy.subject, policy.object).revoke?
  # end

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
                                                        ObjectPolicyAgent.new(:Publisher, publisher)),
                             publisher)
    end
  end

  def newspapers
    model.newspapers.map do |newspaper|
      NewspaperPresenter.new(user, NewspapersPolicy.new(policy.subject,
                                                        ObjectPolicyAgent.new(:Newspaper, newspaper)),
                             newspaper)
    end
  end

  def groups
    model.groups.map do |group|
      GroupPresenter.new(user, GroupsPolicy.new(policy.subject,
                                                ObjectPolicyAgent.new(:Group, group)),
                         group)
    end
  end
end

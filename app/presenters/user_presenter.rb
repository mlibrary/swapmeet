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

  def permit?
    policy.permit?
  end

  def revoke?
    policy.revoke?
  end

  delegate :username, :display_name, :email, to: :model
  # delegate :username, :display_name, :email, :listings, :newspapers, :publishers, :groups, to: :model

  def label
    return model.display_name if model.display_name.present?
    'USER'
  end

  def listings?
    !model.listings.empty?
  end

  def listings
    ListingsPresenter.new(user, ListingPolicy.new(policy.subject, policy.object), model.listings)
  end

  def publishers?
    !model.publishers.empty?
  end

  def publishers
    PublishersPresenter.new(user, PublishersPolicy.new(policy.subject, policy.object), model.publishers)
  end

  def newspapers?
    !model.newspapers.empty?
  end

  def newspapers
    NewspapersPresenter.new(user, NewspapersPolicy.new(policy.subject, policy.object), model.newspapers)
  end

  def groups?
    !model.groups.empty?
  end

  def groups
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.groups)
  end
end

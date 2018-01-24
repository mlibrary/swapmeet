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

  def administrator?
    policy.administrator?
  end

  def permit?
    policy.permit?
  end

  def revoke?
    policy.revoke?
  end

  def label
    return display_name if display_name.present?
    'USER'
  end

  delegate :username, :display_name, :email, to: :model

  def listings
    ListingsPresenter.new(user, ListingPolicy.new(policy.subject, policy.object), model.listings)
  end

  def publishers
    PublishersPresenter.new(user, PublishersPolicy.new(policy.subject, policy.object), model.publishers)
  end

  def newspapers
    NewspapersPresenter.new(user, NewspapersPolicy.new(policy.subject, policy.object), model.newspapers)
  end

  def groups
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.groups)
  end
end

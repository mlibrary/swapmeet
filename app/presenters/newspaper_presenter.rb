# frozen_string_literal: true

class NewspaperPresenter < ApplicationPresenter
  attr_reader :publishers

  delegate :add?, :remove?, to: :policy

  def permit?(user)
    policy.revoke?(user.policy.object)
  end

  def revoke?(user)
    policy.revoke?(user.policy.object)
  end

  delegate :name, :display_name, to: :model

  def label
    return model.display_name if model.display_name.present?
    'NEWSPAPER'
  end

  def publisher?
    model.publisher.present?
  end

  def publisher
    PublisherPresenter.new(user, PublishersPolicy.new(policy.subject, PublisherPolicyAgent.new(model.publisher)), model.publisher)
  end

  def publishers
    @publishers ||= Publisher.all.map { |publisher| [publisher.display_name, publisher.id] }
  end

  def listings?
    !model.listings.empty?
  end

  def listings
    ListingsPresenter.new(user, ListingPolicy.new(policy.subject, policy.object), model.listings)
  end

  def groups?
    !model.groups.empty?
  end

  def groups
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.groups)
  end

  def user?(usr = nil)
    return true if administrator?(usr) if usr.present?
    return model.users.exists?(usr.model.id) if usr.present?
    return true if PolicyResolver.new(policy.subject, PolicyMaker::ROLE_ADMINISTRATOR, PublisherPolicyAgent.new(model.publisher))
    model.users.exists?(user.id)
  end

  def users?
    !model.users.empty?
  end

  def users
    UsersPresenter.new(user, UsersPolicy.new(policy.subject, policy.object), model.users)
  end
end

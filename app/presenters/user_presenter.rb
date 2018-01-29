# frozen_string_literal: true

class UserPresenter < ApplicationPresenter
  delegate :username, :display_name, :email, to: :model

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

  def privilege?(object = nil)
    if object.present?
      PolicyMaker.exists?(policy.object, PolicyMaker::ROLE_ADMINISTRATOR, object.policy.object)
    else
      PolicyMaker.exists?(policy.object, PolicyMaker::ROLE_ADMINISTRATOR, PolicyMaker::OBJECT_ANY)
    end
  end

  def privilege(object = nil)
    if object.present?
      PrivilegePresenter.new(user, PrivilegesPolicy.new(policy.subject, object.policy.object), object.model)
    else
      PrivilegePresenter.new(user, PrivilegesPolicy.new(policy.subject, policy.object), model)
    end
  end

  def user?(object)
    object.model.users.exists?(policy.object.client.id)
  end

  def add?(object)
    object.policy.add?(policy.object)
  end

  def remove?(object)
    object.policy.remove?(policy.object)
  end
end

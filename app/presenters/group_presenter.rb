# frozen_string_literal: true

class GroupPresenter < ApplicationPresenter
  delegate :join?, :leave?, to: :policy

  def administrator?(user = nil)
    policy.administrator_user?(user.policy.object) if user.present?
    policy.administrator?
  end

  delegate :name, :display_name, to: :model

  def label
    return model.display_name if model.display_name.present?
    'GROUP'
  end

  def parent?
    model.parent.present?
  end

  def parent
    GroupPresenter.new(user, GroupsPolicy.new(policy.subject, GroupPolicyAgent.new(model.parent)), model.parent)
  end

  def children?
    !model.children.empty?
  end

  def children
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.children)
  end

  def publishers?
    !model.publishers.empty?
  end

  def publishers
    PublishersPresenter.new(user, PublishersPolicy.new(policy.subject, policy.object), model.publishers)
  end

  def newspapers?
    !model.newspapers.emtpy?
  end

  def newspapers
    NewspapersPresenter.new(user, NewspapersPolicy.new(policy.subject, policy.object), model.newspapers)
  end

  def user?(user = nil)
    return model.users.exists?(user.model.id) if user.present?
    model.users.exists?(self.user.id)
  end

  def users?
    !model.users.empty?
  end

  def users
    UsersPresenter.new(user, UsersPolicy.new(policy.subject, policy.object), model.users)
  end
end

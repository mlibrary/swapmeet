# frozen_string_literal: true

class GroupPresenter < ApplicationPresenter
  delegate :join?, :leave?, to: :policy

  def label
    return display_name if display_name.present?
    'GROUP'
  end

  delegate :name, :display_name, to: :model

  def parent?
    model.parent.present?
  end

  def parent
    GroupPresenter.new(user,
                       GroupsPolicy.new(policy.subject, GroupPolicyAgent.new(model.parent)),
                       model.parent)
  end

  def children
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.children)
  end

  def publishers
    PublishersPresenter.new(user, PublishersPolicy.new(policy.subject, policy.object), model.publishers)
  end

  def newspapers
    NewspapersPresenter.new(user, NewspapersPolicy.new(policy.subject, policy.object), model.newspapers)
  end

  def member?
    model.users.exists?(user.id)
  end

  def users
    UsersPresenter.new(user, UsersPolicy.new(policy.subject, policy.object), model.users)
  end
end

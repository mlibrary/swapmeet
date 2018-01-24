# frozen_string_literal: true

class PublisherPresenter < ApplicationPresenter
  delegate :permit?, :revoke?, to: :policy

  def privilege?(user)
    policy.privilege?(user.policy.object)
  end

  def label
    return display_name if display_name.present?
    'PUBLISHER'
  end

  delegate :name, :display_name, to: :model

  def domain?
    model.domain.present?
  end

  def domain
    DomainPresenter.new(user,
                        DomainsPolicy.new(policy.subject, DomainPolicyAgent.new(model.domain)),
                        model.domain)
  end

  def newspapers
    NewspapersPresenter.new(user, NewspapersPolicy.new(policy.subject, policy.object), model.newspapers)
  end

  def groups
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.groups)
  end

  def users
    UsersPresenter.new(user, UsersPolicy.new(policy.subject, policy.object), model.users)
  end
end

# frozen_string_literal: true

class PublisherPresenter < ApplicationPresenter
  attr_reader :domains

  delegate :add?, :remove?, to: :policy

  def permit?(user)
    policy.permit_user?(user.policy.object)
  end

  def revoke?(user)
    policy.revoke_user?(user.policy.object)
  end

  delegate :name, :display_name, to: :model

  def label
    return model.display_name if model.display_name.present?
    'PUBLISHER'
  end

  def domain?
    model.domain.present?
  end

  def domain
    DomainPresenter.new(user, DomainsPolicy.new(policy.subject, DomainPolicyAgent.new(model.domain)), model.domain)
  end

  def domains
    @domains = Domain.all.map { |domain| [domain.display_name, domain.id] }
  end

  def newspaper?(newspaper = nil)
    model.newspapers.exists?(newspaper.model.id) if newspaper.present?
    false
  end

  def newspapers?
    !model.newspapers.empty?
  end

  def newspapers
    NewspapersPresenter.new(user, NewspapersPolicy.new(policy.subject, policy.object), model.newspapers)
  end

  def group?(group = nil)
    model.groups.exists?(group.model.id) if group.present?
    model.groups.exists?(self.user.id)
  end

  def groups?
    !model.groups.empty?
  end

  def groups
    GroupsPresenter.new(user, GroupsPolicy.new(policy.subject, policy.object), model.groups)
  end

  def user?(user = nil)
    return true if administrator?(user)
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

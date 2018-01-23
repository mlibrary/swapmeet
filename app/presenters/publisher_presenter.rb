# frozen_string_literal: true

class PublisherPresenter < ApplicationPresenter
  def administrator?
    policy.administrator?
  end

  def permit?(user)
    policy.revoke?(user.policy.object)
  end

  def revoke?(user)
    policy.revoke?(user.policy.object)
  end

  def label
    return display_name if display_name.present?
    'PUBLISHER'
  end

  delegate :name, :display_name, to: :model

  def domain
    DomainPresenter.new(user,
                        DomainsPolicy.new(policy.subject,
                                          DomainPolicyAgent.new(model.domain)),
                        model.domain)
  end

  def newspapers
    NewspapersPresenter.new(user, policy, model.newspapers)
  end

  def groups
    GroupsPresenter.new(user, policy, model.groups)
  end

  def users
    UsersPresenter.new(user, policy, model.users)
  end

  def has_user?(user)
    model.has_user?(user.model)
  end
end

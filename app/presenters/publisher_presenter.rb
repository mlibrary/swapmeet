# frozen_string_literal: true

class PublisherPresenter < ApplicationPresenter
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
    model.newspapers.map do |newspaper|
      NewspaperPresenter.new(user, NewspapersPolicy.new(policy.subject,
                                                   NewspaperPolicyAgent.new(newspaper)),
                           newspaper)
    end
  end

  def groups
    model.groups.map do |group|
      GroupPresenter.new(user, GroupsPolicy.new(policy.subject,
                                                GroupPolicyAgent.new(group)),
                         group)
    end
  end

  def users
    model.users.map do |usr|
      UserPresenter.new(user, UsersPolicy.new(policy.subject,
                                              UserPolicyAgent.new(usr)),
                        usr)
    end
  end
end

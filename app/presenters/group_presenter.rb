# frozen_string_literal: true

class GroupPresenter < ApplicationPresenter
  def label
    return display_name if display_name.present?
    'GROUP'
  end

  delegate :name, :display_name, to: :model

  def parent
    GroupPresenter.new(user, GroupsPolicy.new(policy.subject,
                                              GroupPolicyAgent.new(model.parent)),
                       model.parent)
  end

  def children
    model.children.map do |child|
      GroupPresenter.new(user, GroupsPolicy.new(policy.subject,
                                                GroupPolicyAgent.new(child)),
                         child)
    end
  end

  def publishers
    model.publishers.map do |publisher|
      PublisherPresenter.new(user, PublishersPolicy.new(policy.subject,
                                                        PublisherPolicyAgent.new(publisher)),
                             publisher)
    end
  end

  def newspapers
    model.newspapers.map do |newspaper|
      NewspaperPresenter.new(user, NewspapersPolicy.new(policy.subject,
                                                        NewspaperPolicyAgent.new(newspaper)),
                             newspaper)
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

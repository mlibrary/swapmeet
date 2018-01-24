# frozen_string_literal: true

class DomainPresenter < ApplicationPresenter
  delegate :name, :display_name, to: :model

  def label
    return model.display_name if model.display_name.present?
    'DOMAIN'
  end

  def parent?
    model.parent.present?
  end

  def parent
    DomainPresenter.new(user, DomainsPolicy.new(policy.subject, DomainPolicyAgent.new(model.parent)), model.parent)
  end

  def children
    DomainsPresenter.new(user, DomainsPolicy.new(policy.subject, policy.object), model.children)
  end

  def publishers
    PublishersPresenter.new(user, PublishersPolicy.new(policy.subject, policy.object), model.publishers)
  end
end

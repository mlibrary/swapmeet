# frozen_string_literal: true

class DomainPresenter < ApplicationPresenter
  def label
    return display_name if display_name.present?
    'DOMAIN'
  end

  delegate :name, :display_name, to: :model


  def parent
    DomainPresenter.new(user, DomainsPolicy.new(policy.subject,
                                              ObjectPolicyAgent.new(:Domain, model.parent)),
                       model.parent)
  end

  def children
    model.children.map do |child|
      DomainPresenter.new(user, DomainsPolicy.new(policy.subject,
                                                ObjectPolicyAgent.new(:Domain, child)),
                         child)
    end
  end

  def publishers
    model.publishers.map do |publisher|
      PublisherPresenter.new(user, PublishersPolicy.new(policy.subject,
                                                        ObjectPolicyAgent.new(:Publisher, publisher)),
                             publisher)
    end
  end
end

# frozen_string_literal: true

class DomainEditor < ApplicationEditor
  attr_reader :domains

  def initialize(user, policy, model)
    super(user, policy, model)
    @domains = Domain.all.map { |domain| [domain.display_name, domain.id] }
  end

  delegate :name, :display_name, :parent, :children, :publishers, to: :model

  def parent?
    parent.present?
  end

  def children?
    children.empty?
  end

  def publishers?
    publishers.empty?
  end
end

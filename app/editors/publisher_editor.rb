# frozen_string_literal: true

class PublisherEditor < ApplicationEditor
  attr_reader :domains

  def initialize(user, policy, model)
    super(user, policy, model)
    @domains = Domain.all.map { |domain| [domain.display_name, domain.id] }
  end

  delegate :name, :display_name, :domain, :newspapers, :users, :groups, to: :model

  def domain?
    domain.present?
  end

  def users?
    users.empty?
  end

  def groups?
    groups.empty?
  end

  def newspapers?
    newspapers.empty?
  end
end

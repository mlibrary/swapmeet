# frozen_string_literal: true

class UserEditor < ApplicationEditor
  # attr_reader :domains

  def initialize(user, policy, model)
    super(user, policy, model)
    # @domains = Domain.all.map { |domain| [domain.display_name, domain.id] }
  end

  delegate :username, :display_name, :email, :listings, :newspapers, :publishers, :groups, to: :model

  def publishers?
    publishers.empty?
  end

  def listings?
    listings.empty?
  end

  def groups?
    groups.empty?
  end

  def newspapers?
    newspapers.empty?
  end
end

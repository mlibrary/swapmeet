# frozen_string_literal: true

class NewspaperEditor < ApplicationEditor
  attr_reader :publishers

  def initialize(user, policy, model)
    super(user, policy, model)
    @publishers = Publisher.all.map { |publisher| [publisher.display_name, publisher.id] }
  end

  delegate :name, :display_name, :publisher, :listings, :users, :groups, to: :model

  def publisher?
    publisher.present?
  end

  def listings?
    listings.empty?
  end

  def users?
    users.empty?
  end

  def groups?
    groups.empty?
  end
end

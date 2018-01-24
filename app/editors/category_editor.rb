# frozen_string_literal: true

class CategoryEditor < ApplicationEditor
  def initialize(user, policy, model)
    super(user, policy, model)
  end

  delegate :name, :display_name, :title, :listings, to: :model

  def listings?
    listings.empty?
  end
end

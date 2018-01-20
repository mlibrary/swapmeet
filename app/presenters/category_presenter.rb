# frozen_string_literal: true

class CategoryPresenter < ApplicationPresenter
  def label
    return display_name if display_name.present?
    'CATEGORY'
  end

  delegate :name, :display_name, :title, to: :model

  def listings
    model.listings.map do |listing|
      ListingPresenter.new(user, ListingPolicy.new(policy.subject,
                                                   ListingPolicyAgent.new(listing)),
                           listing)
    end
  end
end

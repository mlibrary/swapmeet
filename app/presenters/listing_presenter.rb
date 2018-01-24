# frozen_string_literal: true

class ListingPresenter < ApplicationPresenter
  delegate :title, :body, to: :model

  def label
    return model.title if model.title.present?
    'LISTING'
  end

  def category
    CategoryPresenter.new(user, CategoriesPolicy.new(policy.subject, CategoryPolicyAgent.new(model.category)), model.category)
  end

  def newspaper
    NewspaperPresenter.new(user, NewspapersPolicy.new(policy.subject, NewspaperPolicyAgent.new(model.newspaper)), model.newspaper)
  end

  def owner
    UserPresenter.new(user, UsersPolicy.new(policy.subject, UserPolicyAgent.new(model.owner)), model.owner)
  end
end

# frozen_string_literal: true

class ListingPresenter < ApplicationPresenter
  def label
    return title if title.present?
    'LISTING'
  end

  delegate :title, :body, to: :model

  def category
    CategoryPresenter.new(user,
                          CategoriesPolicy.new(policy.subject,
                                               ObjectPolicyAgent.new(:Category, model.category)),
                          model.category)
  end

  def newspaper
    NewspaperPresenter.new(user,
                           NewspapersPolicy.new(policy.subject,
                                                ObjectPolicyAgent.new(:Newspaper, model.newspaper)),
                           model.newspaper)
  end

  def owner
    UserPresenter.new(user,
                      UsersPolicy.new(policy.subject,
                                      UserPolicyAgent.new(model.owner)),
                      model.owner)
  end
end

# frozen_string_literal: true

class ListingEditor < ApplicationEditor
  attr_reader :categories
  attr_reader :newspapers

  def initialize(user, policy, model)
    super(user, policy, model)
    @categories = Category.all.map { |category| [category.display_name, category.id] }
    @newspapers = Newspaper.all.map { |newspaper| [newspaper.display_name, newspaper.id] }
  end

  delegate :title, :body, :owner, :category, :newspaper, to: :model

  def owner?
    owner.present?
  end

  def category?
    category.present?
  end

  def newspaper?
    newspaper.present?
  end
end

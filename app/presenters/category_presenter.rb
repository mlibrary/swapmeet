# frozen_string_literal: true

class CategoryPresenter < ApplicationPresenter
  def label
    model.display_name
  end
end

# frozen_string_literal: true

class GroupPresenter < ApplicationPresenter
  def label
    model.display_name
  end
end

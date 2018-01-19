# frozen_string_literal: true

class UserPresenter < ApplicationPresenter
  def label
    model.display_name
  end
end

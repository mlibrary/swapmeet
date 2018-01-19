# frozen_string_literal: true

class NewspaperPresenter < ApplicationPresenter
  def label
    if model.display_name
      model.display_name
    else
      'NEWSPAPER'
    end
  end
end

# frozen_string_literal: true

class DomainPresenter < ApplicationPresenter
  def label
    model.display_name
  end
end

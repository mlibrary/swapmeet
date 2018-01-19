# frozen_string_literal: true

class PublisherPresenter < ApplicationPresenter
  def label
    model.display_name
  end
end

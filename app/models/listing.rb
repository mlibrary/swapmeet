# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :newspaper, optional: true

  def owner
    super || User.nobody
  end
end

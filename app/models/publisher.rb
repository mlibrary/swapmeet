# frozen_string_literal: true

class Publisher < ApplicationRecord
  belongs_to :domain, optional: true
  has_many :newspapers
end

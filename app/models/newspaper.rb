# frozen_string_literal: true

class Newspaper < ApplicationRecord
  belongs_to :publisher
  has_many :listings
end

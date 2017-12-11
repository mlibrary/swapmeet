# frozen_string_literal: true

class Publisher < ApplicationRecord
  belongs_to :domain, optional: true
end

# frozen_string_literal: true

class Domain < ApplicationRecord
  has_many :children, class_name: "Domain", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Domain", optional: true
end

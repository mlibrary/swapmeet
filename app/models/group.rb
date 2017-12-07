# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :children, class_name: "Group", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Group", optional: true
  has_and_belongs_to_many :users
end

# frozen_string_literal: true

class Privilege
  include ActiveModel::Model
  attr_accessor :id
  attr_accessor :requestor
  attr_accessor :subject_type
  attr_accessor :subject_id
  attr_accessor :verb_type
  attr_accessor :verb_id
  attr_accessor :object_type
  attr_accessor :object_id
end

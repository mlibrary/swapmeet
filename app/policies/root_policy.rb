# frozen_string_literal: true

class RootPolicy < ApplicationPolicy
  def method_missing(method_name, *args, &block)
    return true if method_name[-1] == '?'
    super
  end
end

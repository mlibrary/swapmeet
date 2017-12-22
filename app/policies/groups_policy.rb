# frozen_string_literal: true

class GroupsPolicy < ApplicationPolicy
  def add?
    true
  end

  def remove?
    true
  end
end

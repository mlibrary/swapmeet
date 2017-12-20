# frozen_string_literal: true

class PublishersPolicy < ApplicationPolicy
  def index?
    return true if subject.platform_administrator?
    false
  end

  def show?(publisher = nil)
    return true if subject.platform_administrator?
    false
  end

  def create?
    return true if subject.platform_administrator?
    false
  end

  def update?(publisher = nil)
    return true if subject.platform_administrator?
    false
  end

  def destroy?(publisher = nil)
    return true if subject.platform_administrator?
    false
  end
end

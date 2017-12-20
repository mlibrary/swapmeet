# frozen_string_literal: true

class UsersPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?(user = nil)
    return true if subject.application_administrator?
    return true if subject.platform_administrator?
    return true if subject.client == object.client
    return true if subject.client == user
    false
  end

  def create?
    return true if subject.application_administrator?
    false
  end

  def update?(user = nil)
    return true if subject.application_administrator?
    return true if subject.client == object.client
    return true if subject.client == user
    false
  end

  def destroy?(user = nil)
    return true if subject.application_administrator?
    false
  end

  def join?
    return true if subject.client == object.client
    false
  end

  def leave?
    return true if subject.client == object.client
    false
  end
end

# frozen_string_literal: true

class UsersPolicy < ApplicationPolicy
  def edit?(user = nil)
    return true if subject.root?
    return true if subject.client == object.client
    return true if subject.client == user
    false
  end

  def index?
    return true if subject.root?
    true
  end

  def join?
    return true if subject.root?
    return true if subject.client == object.client
    false
  end

  def leave?
    return true if subject.root?
    return true if subject.client == object.client
    false
  end

  def show?(user = nil)
    return true if subject.root?
    return true if subject.client == object.client
    return true if subject.client == user
    false
  end

  def update?(user = nil)
    return true if subject.root?
    return true if subject.client == object.client
    return true if subject.client == user
    false
  end
end

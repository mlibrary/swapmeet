# frozen_string_literal: true

class UsersPolicy < ApplicationPolicy
  def edit?
    return true if subject.root?
    subject.known? && subject.client == object.client
  end

  def index?
    return true if subject.root?
    subject.known?
  end

  def show?
    return true if subject.root?
    subject.known?
  end

  def update?
    return true if subject.root?
    subject.known? && subject.client == object.client
  end
end

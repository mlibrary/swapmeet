# frozen_string_literal: true

class GatekeepersPolicy < ApplicationPolicy
  def create?
    subject.known?
  end

  def edit?
    subject.known?
  end

  def destroy?
    subject.known?
  end

  def index?
    subject.known?
  end

  def new?
    subject.known?
  end

  def show?
    subject.known?
  end

  def update?
    subject.known?
  end
end

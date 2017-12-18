# frozen_string_literal: true

class GatekeepersPolicy < ApplicationPolicy
  def index?
    subject.known?
  end

  def show?(obj = nil)
    subject.known?
  end

  def create?
    subject.known?
  end

  def update?(obj = nil)
    subject.known?
  end

  def destroy?(obj = nil)
    subject.known?
  end
end

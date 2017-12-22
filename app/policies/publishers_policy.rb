# frozen_string_literal: true

class PublishersPolicy < ApplicationPolicy
  def index?
    return false unless subject.known?
    return true if subject.platform_administrator?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :index), object).grant?
  end

  def show?(publisher = nil)
    return false unless subject.known?
    return true if subject.platform_administrator?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :show), object).grant?
  end

  def create?
    return false unless subject.known?
    return true if subject.platform_administrator?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :create), object).grant?
  end

  def update?(publisher = nil)
    return false unless subject.known?
    return true if subject.platform_administrator?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :update), object).grant?
  end

  def destroy?(publisher = nil)
    return false unless subject.known?
    return true if subject.platform_administrator?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :destroy), object).grant?
  end
end

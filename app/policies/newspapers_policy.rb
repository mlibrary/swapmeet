# frozen_string_literal: true

class NewspapersPolicy < ApplicationPolicy
  def index?
    return false unless subject.known?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :index), object).grant?
  end

  def show?(newspaper = nil)
    return false unless subject.known?
    return true if newspaper&.user?(subject.client)
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :show), object).grant?
  end

  def create?(publisher = nil)
    return false unless subject.known?
    return PolicyResolver.new(subject, VerbPolicyAgent.new(:Role, :administrator), ObjectPolicyAgent.new(:Publisher, publisher)).grant? if publisher.present?
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :show), object).grant?
  end

  def add?(newspaper)
    return false unless subject.known?
    return true if newspaper.administrator?(subject.client)
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :add), object).grant?
  end

  def remove?(newspaper)
    return false unless subject.known?
    return true if newspaper.administrator?(subject.client)
    PolicyResolver.new(subject, VerbPolicyAgent.new(:Action, :remove), object).grant?
  end
end

# frozen_string_literal: true

class NewspapersPolicy < ApplicationPolicy
  def index?
    return false unless @subject.client_type == :User.to_s
    true
  end

  def show?
    return false unless @subject.client_type == :User.to_s
    true
  end

  def create?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:create), @object).grant?
  end

  def update?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:update), @object).grant?
  end

  def destroy?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:destroy), @object).grant?
  end

  def add?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, PublisherPolicyAgent.new(@object.client.publisher)).grant?
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:add), @object).grant?
  end

  def remove?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, PublisherPolicyAgent.new(@object.client.publisher)).grant?
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:remove), @object).grant?
  end

  def administrator?(user)
    PolicyResolver.new(user, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
  end

  def permit?(user)
    PolicyMaker.new(@subject).permit?(user, PolicyMaker::ROLE_ADMINISTRATOR, @object)
  end

  def revoke?(user)
    PolicyMaker.new(@subject).revoke?(user, PolicyMaker::ROLE_ADMINISTRATOR, @object)
  end
end

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
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
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

  def administrator?
    return true if @subject.administrator?
    PolicyMaker.exist?(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object)
  end

  def administrator_user?(user)
    PolicyMaker.exist?(user, PolicyMaker::ROLE_ADMINISTRATOR, @object)
  end

  def permit_user?(user)
    PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
  end

  def revoke_user?(user)
    PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
  end
end

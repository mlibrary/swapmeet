# frozen_string_literal: true

class PublishersPolicy < ApplicationPolicy
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
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
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
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:add), @object).grant?
  end

  def remove?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:remove), @object).grant?
  end

  def administrator?
    return true if @subject.administrator?
    PolicyMaker.exist?(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object)
  end

  def administrator_user?(usr)
    PolicyMaker.exist?(usr, PolicyMaker::ROLE_ADMINISTRATOR, @object)
  end

  def permit_user?(user)
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    return false if user.administrator?
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
    PolicyResolver.new(@subject, PolicyMaker::POLICY_PERMIT, @object).grant?
  end

  def revoke_user?(user)
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.administrator?
    return false if user.administrator?
    return true if PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
    PolicyResolver.new(@subject, PolicyMaker::POLICY_REVOKE, @object).grant?
  end
end

# frozen_string_literal: true

class UsersPolicy < ApplicationPolicy
  def index?
    return false unless @subject.client_type == :User.to_s
    true
  end

  def show?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    # return true if @subject.client == @object.client
    # PolicyResolver.new(subject, ActionPolicyAgent.new(:show), object).grant?
    true
  end

  def create?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:create), object).grant?
  end

  def update?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.client == @object.client
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:update), object).grant?
  end

  def destroy?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    # return true if @subject.client == @object.client
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:destroy), object).grant?
  end

  # def show_user?(user)
  #   UsersPolicy.new(@subject, UserPolicyAgent.new(user)).show?
  # end
  #
  # def edit_user?(user)
  #   UsersPolicy.new(@subject, UserPolicyAgent.new(user)).edit?
  # end
  #
  # def destroy_user?(user)
  #   UsersPolicy.new(@subject, UserPolicyAgent.new(user)).destroy?
  # end
  #
  # def administrator_user?(user)
  #   UserPolicyAgent.new(user).administrator?
  # end
  #
  # def permit_user?(user)
  #   return true if @subject.administrator?
  #   PrivilegesPolicy.new(@subject, UserPolicyAgent.new(user)).permit?
  # end
  #
  # def revoke_user?(user)
  #   return true if @subject.administrator?
  #   PrivilegesPolicy.new(@subject, UserPolicyAgent.new(user)).revoke?
  # end

  def join?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.client == @object.client
    PolicyResolver.new(subject, ActionPolicyAgent.new(:join), object).grant?
  end

  def leave?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return true if @subject.client == @object.client
    PolicyResolver.new(subject, ActionPolicyAgent.new(:leave), object).grant?
  end
end

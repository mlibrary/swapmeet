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
    # PolicyResolver.new(@subject, ActionPolicyAgent.new(:show), @object).grant?
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
    return true if @subject.client == @object.client
    return true if @subject.administrator?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:update), @object).grant?
  end

  def destroy?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    # return true if @subject.client == @object.client
    return true if @subject.administrator?
    PolicyResolver.new(@subject, ActionPolicyAgent.new(:destroy), @object).grant?
  end

  # def join?
  #   return false unless @subject.client_type == :User.to_s
  #   return false unless @subject.authenticated?
  #   return true if @subject.client == @object.client
  #   PolicyResolver.new(@subject, ActionPolicyAgent.new(:join), @object).grant?
  # end

  # def join?(object)
  #   PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, object).grant?
  # end

  # def leave?
  #   return false unless @subject.client_type == :User.to_s
  #   return false unless @subject.authenticated?
  #   return true if @subject.client == @object.client
  #   PolicyResolver.new(@subject, ActionPolicyAgent.new(:leave), @object).grant?
  # end

  # def leave?(object)
  #   PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, object).grant?
  # end
  #
  # def add?(object)
  #   PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, object).grant?
  # end
  #
  # def remove?(object)
  #   PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, object).grant?
  # end
  #
  # def administrator?(user)
  #   PolicyResolver.new(user, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
  # end
  #
  # def permit?(_user)
  #   PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
  # end
  #
  # def revoke?(_user)
  #   PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, @object).grant?
  # end

  def administrator?
    PolicyResolver.new(@object, PolicyMaker::ROLE_ADMINISTRATOR, PolicyMaker::OBJECT_ANY).grant?
  end

  def permit?
    PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, PolicyMaker::OBJECT_ANY).grant?
  end

  def revoke?
    PolicyResolver.new(@subject, PolicyMaker::ROLE_ADMINISTRATOR, PolicyMaker::OBJECT_ANY).grant?
  end
end

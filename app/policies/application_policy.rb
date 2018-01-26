# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def administrator?
    PolicyResolver.new(subject, PolicyMaker::ROLE_ADMINISTRATOR, object).grant?
  end

  def administrator_agent?(agent)
    PolicyResolver.new(agent, PolicyMaker::ROLE_ADMINISTRATOR, object).grant?
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def authorize!(action, message = nil)
    return if send(action)
    return if PolicyResolver.new(subject, ActionPolicyAgent.new(action.to_s.chop.to_sym), object).grant?
    raise NotAuthorizedError.new(message)
  end

  def respond_to_missing?(method_name, include_private = false)
    return true if method_name[-1] == '?'
    super
  end

  def method_missing(method_name, *args, &block)
    return super if method_name[-1] != '?'
    PolicyResolver.new(subject, ActionPolicyAgent.new(method_name.to_s.chop.to_sym), object).grant?
  end
end

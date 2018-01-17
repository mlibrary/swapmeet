# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def authorize!(action, message = nil)
    return if send(action)
    verb = VerbPolicyAgent.new(:Action, action.to_s.chop.to_sym)
    return if PolicyResolver.new(subject, verb, object).grant?
    raise NotAuthorizedError.new(message)
  end

  def respond_to_missing?(method_name, include_private = false)
    return true if method_name[-1] == '?'
    super
  end

  def method_missing(method_name, *args, &block)
    return super if method_name[-1] != '?'
    verb = VerbPolicyAgent.new(:Action, method_name.to_s.chop.to_sym)
    PolicyResolver.new(subject, verb, object).grant?
  end
end

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

  def edit?(obj = nil)
    update?(obj)
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end

  def respond_to_missing?(method_name, include_private = false)
    return true if method_name[-1] == '?'
    super
  end

  def method_missing(method_name, *args, &block)
    return false if method_name[-1] == '?'
    super
  end
end

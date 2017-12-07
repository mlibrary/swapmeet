# frozen_string_literal: true

# Sample resource-oriented, multi-rule policy
class GatekeepersPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def create?
    subject.known?
  end

  def edit?
    subject.known?
  end

  def destroy?
    subject.known?
  end

  def index?
    subject.known?
  end

  def new?
    subject.known?
  end

  def show?
    subject.known?
  end

  def update?
    subject.known?
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

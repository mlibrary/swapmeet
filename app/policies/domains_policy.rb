# frozen_string_literal: true

# Sample resource-oriented, multi-rule policy
class DomainsPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def create?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end

  def index?
    false
  end

  def new?
    false
  end

  def show?
    false
  end

  def update?
    false
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

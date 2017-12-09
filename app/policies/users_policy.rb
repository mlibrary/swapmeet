# frozen_string_literal: true

# Sample resource-oriented, multi-rule policy
class UsersPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def create?
    return true if subject.root?
    false
  end

  def destroy?
    return true if subject.root?
    false
  end

  def edit?
    return true if subject.root?
    subject.known? && subject.client == object.client
  end

  def index?
    return true if subject.root?
    subject.known?
  end

  def new?
    return true if subject.root?
    false
  end

  def show?
    return true if subject.root?
    subject.known?
  end

  def update?
    return true if subject.root?
    subject.known? && subject.client == object.client
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

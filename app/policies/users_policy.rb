# frozen_string_literal: true

# Sample resource-oriented, multi-rule policy
class UsersPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def create?
    true
  end

  def edit?
    subject.id.present? && subject.owner == object
  end

  def destroy?
    subject.id.present? && subject.owner == object
  end

  def index?
    true
  end

  def new?
    true
  end

  def show?
    subject.id.present? && subject.owner == object
  end

  def update?
    subject.id.present? && subject.owner == user
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def index?
    return true if subject.root?
    false
  end

  def show?(obj = nil)
    return true if subject.root?
    false
  end

  def new?
    create?
  end

  def edit?(obj = nil)
    update?(obj)
  end

  def create?
    return true if subject.root?
    false
  end

  def update?(obj = nil)
    return true if subject.root?
    false
  end

  def destroy?(obj = nil)
    return true if subject.root?
    false
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

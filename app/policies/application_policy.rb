# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :subject, :object

  def initialize(subject, object)
    @subject = subject
    @object = object
  end

  def index?
    false
  end

  def show?(obj = nil)
    false
  end

  def new?
    create?
  end

  def edit?(obj = nil)
    update?(obj)
  end

  def create?
    false
  end

  def update?(obj = nil)
    false
  end

  def destroy?(obj = nil)
    false
  end

  def authorize!(action, message = nil)
    return true if Rails.application.config.administrators[:root].include?(subject.client.email) if subject&.client&.respond_to?(:email)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

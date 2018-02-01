# frozen_string_literal: true

class CollectionPolicy
  attr_reader :user, :scope

  def initialize(user, scope = nil)
    @user  = user
    @scope = scope || base_scope
  end

  def base_scope
    ApplicationRecord.none
  end

  def index?
    true
  end

  def new?
    false
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless public_send(action)
  end
end


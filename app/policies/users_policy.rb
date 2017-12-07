# frozen_string_literal: true

# Sample resource-oriented, multi-rule policy
class UsersPolicy
  attr_reader :agent, :user

  def initialize(agent, user)
    @agent = agent
    @user = user
  end

  def create?
    # agent.id.present?
    true
  end

  def edit?
    agent.id.present? && agent.owner == user
  end

  def destroy?
    agent.id.present? && agent.owner == user
  end

  def login?
    true
  end

  def logout?
    true
  end

  def index?
    true
  end

  def new?
    # agent.id.present?
    true
  end

  def show?
    agent.id.present? && agent.owner == user
  end

  def update?
    agent.id.present? && agent.owner == user
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send(action)
  end
end

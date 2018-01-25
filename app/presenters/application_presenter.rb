# frozen_string_literal: true

class ApplicationPresenter
  attr_reader :user, :policy
  attr_accessor :model

  def initialize(user, policy, model)
    @user = user
    @policy = policy
    @model = model
  end

  delegate :index?, :show?, :new?, :create?, :edit?, :update?, :destroy?, to: :policy

  def administrator?(user = nil)
    policy.administrator_user?(user.policy.object) if user.present?
    policy.administrator?
  end

  delegate :to_model, :errors, :persisted?, to: :model
end

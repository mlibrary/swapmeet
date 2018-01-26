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

  def administrator?(usr = nil)
    if usr.present? # object is an administrator?
      policy.administrator_agent?(usr.policy.object)
    else # subject is an administrator?
      policy.administrator?
    end
  end

  delegate :to_model, :errors, :persisted?, to: :model
end

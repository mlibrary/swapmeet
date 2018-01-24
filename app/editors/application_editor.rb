# frozen_string_literal: true

class ApplicationEditor
  attr_reader :user, :policy
  attr_accessor :model

  def initialize(user, policy, model)
    @user = user
    @policy = policy
    @model = model
  end

  delegate :index?, :show?, :new?, :create?, :edit?, :update?, :destroy?, to: :policy

  delegate :to_model, :errors, :persisted?, to: :model
end

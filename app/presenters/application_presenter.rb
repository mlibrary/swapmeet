# frozen_string_literal: true

class ApplicationPresenter
  attr_reader :user, :policy, :model

  def initialize(user, policy, model)
    @user = user
    @policy = policy
    @model = model
  end

  delegate :index?, :show?, :new?, :create?, :edit?, :update?, :destroy?, to: :policy
end

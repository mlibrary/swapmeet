# frozen_string_literal: true

Services = Canister.new

class NullPresenter < SimpleDelegator
  def initialize(object, *)
    __setobj__ object
  end
end

class ReadOnlyPolicy < ResourcePolicy
  def show?
    true
  end
end

class PresenterConfig
  def initialize(type, presenter, policy)
    @type_name      = type.to_s
    @presenter_name = presenter.to_s
    @policy_name    = policy.to_s
  end

  def present(object, user, view)
    presenter.new(policy.new(user, object), view)
  end

  def type
    # Cache these, but only in production... Old classes persist over reload.
    # @type ||= Object.const_get(@type_name)
    Object.const_get(@type_name)
  end

  def presenter
    # @presenter ||= Object.const_get(@presenter_name)
    Object.const_get(@presenter_name)
  end

  def policy
    # @policy ||= Object.const_get(@policy_name)
    Object.const_get(@policy_name)
  end
end

class Presenters
  PRESENTERS = {
    Listing => [ListingPresenter, ListingPolicy],
    User    => [UserPresenter, ReadOnlyPolicy],
    'Listing::ActiveRecord_Relation' => [ListingsPresenter, ListingsPolicy],
  }

  def initialize
    @configs = Hash.new do |presenters, type|
      PresenterConfig.new(type, NullPresenter, ReadOnlyPolicy)
    end

    PRESENTERS.each do |type, config|
      @configs[type.to_s] = PresenterConfig.new(type, config.first, config.last)
    end
  end

  def [](object, user, view)
    configs[object.class.to_s].present(object, user, view)
  end

  private

    attr_accessor :configs
end

Services.register(:presenters) { Presenters.new }

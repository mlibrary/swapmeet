# frozen_string_literal: true

# Mapping for a given type to presenter and policy types
#
# This configuration does not cache the constant lookups,
# so it supports reloading of the types in development.
# The CachingPresenterConfig should be used in production.
module Vizier
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
      Object.const_get(@type_name)
    end

    def presenter
      Object.const_get(@presenter_name)
    end

    def policy
      Object.const_get(@policy_name)
    end
  end
end

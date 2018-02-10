# frozen_string_literal: true

require_relative 'presenter_factory'

module Vizier
  class ResourcePresenter < SimpleDelegator
    extend Forwardable

    def initialize(policy, view, presenter_factory: PresenterFactory.new)
      @policy = policy
      @view   = view
      @presenter_factory = presenter_factory
      __setobj__ policy.resource
    end

    protected

      def resource
        policy.resource
      end

      def present(object)
        presenter_factory[object, policy.user, view]
      end

      attr_reader :policy, :view, :presenter_factory
  end
end

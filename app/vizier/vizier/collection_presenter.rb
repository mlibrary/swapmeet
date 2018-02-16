# frozen_string_literal: true

module Vizier
  class CollectionPresenter
    include Enumerable

    def initialize(policy, view, presenter_factory: PresenterFactory.new)
      @policy = policy
      @view   = view
      @presenter_factory = presenter_factory
    end

    def each
      resources.each { |resource| yield resource }
    end

    def empty?
      resources.empty?
    end

    protected

      def resources
        @resources ||= policy.resolve.map do |resource|
          present(resource)
        end
      end

      def present(resource)
        presenter_factory[resource, policy.user, view]
      end

      attr_reader :policy, :view, :presenter_factory
  end
end

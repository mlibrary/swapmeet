# frozen_string_literal: true

class ResourcePresenter < SimpleDelegator
  extend Forwardable

  def initialize(policy, view, presenter_factory: Services.presenters)
    @policy = policy
    @view   = view
    @presenter_factory = presenter_factory
    __setobj__ policy.resource
  end

  private

    def resource
      policy.resource
    end

    def present(object)
      presenter_factory[object, policy.user, view]
    end

    attr_reader :policy, :view, :presenter_factory
end

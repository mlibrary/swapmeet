# frozen_string_literal: true

require_relative 'presenter_config'

# A presenter configuration that caches the type lookup
#
# For development use reloading is convenient, but in production
# the constants should not be redefined. We cache them here to
# avoid repeated global lookups.
module Vizier
  class CachingPresenterConfig < PresenterConfig
    def type
      @type ||= super
    end

    def presenter
      @presenter ||= super
    end

    def policy
      @policy ||= super
    end
  end
end

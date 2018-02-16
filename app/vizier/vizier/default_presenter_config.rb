# frozen_string_literal: true

module Vizier
  class DefaultPresenterConfig
    attr_reader :config_type

    def initialize(config_type)
      @config_type = config_type
    end

    def for(type)
      config_type.new(type, NullPresenter, ReadOnlyPolicy)
    end
  end
end

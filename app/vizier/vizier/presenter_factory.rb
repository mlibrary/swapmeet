# frozen_string_literal: true

require_relative 'presenter_config'
require_relative 'default_presenter_config'

# Factory for locating and creating a presenter based on an object's type
module Vizier
  class PresenterFactory
    def initialize(
        presenter_map = {},
        config_type: PresenterConfig,
        default_config: DefaultPresenterConfig.new(config_type))

      @config_type    = config_type
      @default_config = default_config

      @configs = Hash.new do |configs, type|
        default_config.for(type)
      end

      presenter_map.each do |type, config|
        @configs[type.to_s] = config_type.new(type, config.first, config.last)
      end
    end

    def [](object, user, view)
      configs[object.class.to_s].present(object, user, view)
    end

    private

      attr_accessor :configs, :config_type, :default_config
  end
end

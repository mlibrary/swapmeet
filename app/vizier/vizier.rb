# frozen_string_literal: true

# TODO: turn this into real gem layout
require_relative 'vizier/null_presenter'
require_relative 'vizier/read_only_policy'

require_relative 'vizier/presenter_config'
require_relative 'vizier/caching_presenter_config'
require_relative 'vizier/default_presenter_config'

require_relative 'vizier/collection_presenter'
require_relative 'vizier/resource_presenter'
require_relative 'vizier/presenter_factory'

module Vizier
  VERSION = '0.1.0'
end

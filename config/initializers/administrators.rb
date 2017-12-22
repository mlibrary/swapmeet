# frozen_string_literal: true

require 'yaml'

Rails.application.config.administrators = { application: [], platform: [], root: [] }

administrators = YAML.load_file('config/administrators.yml')

Rails.application.config.administrators[:application].push(*administrators[Rails.env]["application"])
Rails.application.config.administrators[:platform].push(*administrators[Rails.env]["platform"])
Rails.application.config.administrators[:root].push(*administrators[Rails.env]["root"])

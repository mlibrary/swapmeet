# frozen_string_literal: true

PRESENTERS = {
  Listing => [ListingPresenter, ListingPolicy],
  User    => [UserPresenter, Vizier::ReadOnlyPolicy],
  'Listing::ActiveRecord_Relation' => [ListingsPresenter, ListingsPolicy],
}

if Swapmeet.config.cache_presenters
  config_class = Vizier::CachingPresenterConfig
else
  config_class = Vizier::PresenterConfig
end

if Swapmeet.config.checkpoint&.database
  Checkpoint::DB.config.opts = Swapmeet.config.checkpoint.database
end

if Swapmeet.config.keycard&.database
  Keycard::DB.config.opts = Swapmeet.config.keycard.database
end

if Swapmeet.config.keycard&.readonly
  Keycard::DB.config.readonly = true
end

Services = Canister.new
Services.register(:presenters) {
  Vizier::PresenterFactory.new(PRESENTERS, config_type: config_class)
}

Services.register(:checkpoint) { Checkpoint::Authority.new(agent_resolver: KCV::AgentResolver.new) }
Services.register(:request_attributes) { Keycard::Request::AttributesFactory.new }

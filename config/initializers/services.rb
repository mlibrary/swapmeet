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

Services = Canister.new
Services.register(:presenters) {
  Vizier::PresenterFactory.new(PRESENTERS, config_type: config_class)
}

# Way kludgey db config for right now
conn_opts = ActiveRecord::Base.connection.instance_variable_get(:@config)
conn_opts.delete(:flags)
Checkpoint::DB.initialize!(opts: conn_opts.merge(logger: Logger.new('db/permits.log')))

Services.register(:checkpoint) { Checkpoint::Authority.new }

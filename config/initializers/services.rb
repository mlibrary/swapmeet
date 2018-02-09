# frozen_string_literal: true

PRESENTERS = {
  Listing => [ListingPresenter, ListingPolicy],
  User    => [UserPresenter, Vizier::ReadOnlyPolicy],
  'Listing::ActiveRecord_Relation' => [ListingsPresenter, ListingsPolicy],
}

Services = Canister.new
Services.register(:presenters) {
  Vizier::PresenterFactory.new(PRESENTERS, config_type: Rails.configuration.presenter_config)
}

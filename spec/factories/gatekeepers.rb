# frozen_string_literal: true

FactoryBot.define do
  factory :gatekeeper do
    role "Role"
    domain nil
    group nil
    listing nil
    newspaper nil
    publisher nil
    user nil
  end
end

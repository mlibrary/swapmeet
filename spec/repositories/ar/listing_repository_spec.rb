require 'rails_helper'
require 'ar/listing_repository'
require_relative '../listing_repository_examples'

RSpec.describe ActiveRecordRepository::ListingRepository do
  include_examples "Listing Repository"
end

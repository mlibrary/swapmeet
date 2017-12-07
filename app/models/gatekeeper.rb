# frozen_string_literal: true

class Gatekeeper < ApplicationRecord
  belongs_to :domain
  belongs_to :group
  belongs_to :listing
  belongs_to :newspaper
  belongs_to :publisher
  belongs_to :user
end

# frozen_string_literal: true

class ListingPolicyAgent < ObjectPolicyAgent
  def initialize(listing)
    super(:Listing, listing)
  end

  def creator?(user)
    return false if user.nil?
    return false if client.nil?
    user == client.owner
  end
end

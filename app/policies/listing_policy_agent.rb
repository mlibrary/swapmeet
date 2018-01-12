# frozen_string_literal: true

class ListingPolicyAgent < ObjectPolicyAgent
  def initialize(client)
    super(:Listing, client)
  end

  def creator?(user)
    return false if user.nil?
    return false if client.nil?
    user == client.owner
  end
end

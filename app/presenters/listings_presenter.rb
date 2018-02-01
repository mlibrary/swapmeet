# frozen_string_literal: true

class ListingsPresenter
  include Enumerable

  def initialize(policy, view)
    @policy   = policy
    @view     = view
  end

  def each
    listings.each { |l| yield l }
  end

  def empty?
    listings.empty?
  end

  def new?
    policy.new?
  end

  private

    def listings
      @listings ||= policy.resolve.map do |listing|
        ListingPresenter.new(listing, policy.for(listing), view)
      end
    end

    attr_reader :policy, :view
end

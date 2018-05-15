require "rails_helper"

RSpec.describe "/listings/index.html.slim" do
  let(:listings) do
    Array.new(3) do |i|
      double(:listing,
             image: "image#{i}.gif",
             link_or_title: "something",
             show_link: "https://somewhere",
             edit?: false,
             destroy?: false,
             new?: false,
            owner: double(:owner, display_name_link: "idk"))
    end
  end

  class FakeListings
    def initialize(listings)
      @listings = listings
    end

    def new?
      false
    end

    def empty?
      @listings.empty?
    end

    def each
      @listings.each do |listing|
        yield listing
      end
    end
  end

  before(:each) do
    assign(:listings,FakeListings.new(listings))
  end

  it "renders a thumbnail for each event" do
    render
    3.times do |i|
      expect(rendered).to include("<img src=\"/images/image#{i}.gif\" style=\"max-width: 32px\" ")
    end
  end
end

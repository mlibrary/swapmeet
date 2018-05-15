# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/listings/show.html.slim" do
  let(:listing) do
    double(:listing,
           image: "Whatever.gif",
           title: "a title",
           body: "the body",
           category: double(:category, title: "some category"),
           owner: double(:owner, display_name_link: "display_name"),
           edit?: false,
           destroy?: false
          )
  end

  before(:each) do
    assign(:listing, listing)
  end

  it "renders the image" do
    render
    expect(rendered).to include("<img src=\"/images/#{listing.image}\" style=\"max-width: 400px\"")
  end
end

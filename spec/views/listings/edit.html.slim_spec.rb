require "rails_helper"

RSpec.describe "/listings/edit.html.slim" do
  let(:listing) { build(:listing, image: "whatever.gif") }

  before(:each) do
    assign(:listing, listing)
  end

  it "renders a preview of the image" do
    render
    expect(rendered).to include("<img src=\"/images/#{listing.image}\" style=\"max-width: 200px\"")
  end
end

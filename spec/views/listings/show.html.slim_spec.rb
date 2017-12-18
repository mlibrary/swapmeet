# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "listings/show", type: :view do
  let(:category) { build(:category, id: 1) }
  let(:newspaper) { build(:newspaper, id: 1) }
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    @listing = assign(:listing, build(:listing,
                                      id: 1,
                                      title: "Title",
                                      body: "Body",
                                      category: category,
                                      newspaper: newspaper
                                    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Body/)
    expect(rendered).to match(/(No one)/)
    expect(rendered).to match(/Newspaper/)
  end
end

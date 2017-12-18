# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  let(:category) { build(:category, id: 1) }
  let(:newspaper) { build(:newspaper, id: 1) }
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    assign(:listings, [
        build(:listing,
              id: 1,
              title: "Title",
              body: "Body",
              category: category,
              newspaper: newspaper
        ),
        build(:listing,
              id: 2,
              title: "Title",
              body: "Body",
              category: category,
              newspaper: newspaper
        )
    ])
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Newspaper".to_s, count: 2
    assert_select "tr>td", text: "(No one)".to_s, count: 2
  end
end

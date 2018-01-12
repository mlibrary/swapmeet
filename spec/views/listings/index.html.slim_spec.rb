# frozen_string_literal: true

require 'rails_helper'

class AuthorizePolicy < ControllersHelper::AuthorizePolicy
  def edit_listing?(listing); edit?; end
  def destroy_listing?(listing); destroy?; end
end

RSpec.describe "listings/index", type: :view do
  let(:category) { build(:category, id: 1) }
  let(:newspaper) { build(:newspaper, id: 1) }
  before(:each) do
    @policy = AuthorizePolicy.new
    @filter = Filter.new
    @newspapers = []
    @owners = []
    @categories = []
    assign(:listings, [
        build(:listing,
              id: 1,
              title: "Listing Title",
              body: "Listing Body",
              category: category,
              newspaper: newspaper
        ),
        build(:listing,
              id: 2,
              title: "Listing Title",
              body: "Listing Body",
              category: category,
              newspaper: newspaper
        )
    ])
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", text: "Listing Title".to_s, count: 2
    assert_select "tr>td", text: "Newspaper".to_s, count: 2
    assert_select "tr>td", text: "(No one)".to_s, count: 2
  end
end

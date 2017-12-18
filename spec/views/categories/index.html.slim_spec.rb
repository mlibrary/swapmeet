# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    assign(:categories, [
        build(:category,
              id: 1,
              name: "Name",
              display_name: "Display Name",
              title: "Title"
        ),
        build(:category,
              id: 2,
              name: "Name",
              display_name: "Display Name",
              title: "Title"
        )
    ])
  end

  it "renders a list of categories" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Display Name".to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
  end
end

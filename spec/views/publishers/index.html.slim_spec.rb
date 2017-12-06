# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "publishers/index", type: :view do
  before(:each) do
    assign(:publishers, [
      Publisher.create!(
        name: "Name",
        display_name: "Display Name"
      ),
      Publisher.create!(
        name: "Name",
        display_name: "Display Name"
      )
    ])
  end

  it "renders a list of publishers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Display Name".to_s, count: 2
  end
end

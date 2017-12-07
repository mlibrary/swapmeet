# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "gatekeepers/index", type: :view do
  before(:each) do
    assign(:gatekeepers, [
      build(:gatekeeper,
        id: 1,
        role: "Role",
        domain: nil,
        group: nil,
        listing: nil,
        newspaper: nil,
        publisher: nil,
        user: nil
      ),
      build(:gatekeeper,
        id: 2,
        role: "Role",
        domain: nil,
        group: nil,
        listing: nil,
        newspaper: nil,
        publisher: nil,
        user: nil
      )
    ])
  end

  it "renders a list of gatekeepers" do
    render
    assert_select "tr>td", text: "Role".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 12
  end
end

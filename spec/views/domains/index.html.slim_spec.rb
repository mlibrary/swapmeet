# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "domains/index", type: :view do
  before(:each) do
    assign(:domains, [
      build(:domain,
        id: 1,
        name: "Name",
        display_name: "Display Name",
        parent: nil
      ),
      build(:domain,
        id: 2,
        name: "Name",
        display_name: "Display Name",
        parent: nil
      )
    ])
  end

  it "renders a list of domains" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Display Name".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end

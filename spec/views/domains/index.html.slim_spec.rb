# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "domains/index", type: :view do
  before(:each) do
    assign(:domains, [
      Domain.create!(
        name: "Name",
        display_name: "Display Name",
        parent: nil
      ),
      Domain.create!(
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

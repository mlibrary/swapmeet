# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "groups/index", type: :view do
  before(:each) do
    assign(:groups, [
      build(:group,
        id: 1,
        name: "Name",
        display_name: "Display Name"
      ),
      build(:group,
        id: 2,
        name: "Name",
        display_name: "Display Name"
      )
    ])
  end

  it "renders a list of groups" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Display Name".to_s, count: 2
  end
end

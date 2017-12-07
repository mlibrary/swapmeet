# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "groups/new", type: :view do
  before(:each) do
    assign(:group, build(:group,
                     id: 1,
                     name: "Name",
                     display_name: "Display Name"
                   ))
  end

  it "renders new group form" do
    render
    assert_select "form[action=?][method=?]", groups_path, "post" do
      assert_select "input[name=?]", "group[name]"
      assert_select "input[name=?]", "group[display_name]"
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "groups/edit", type: :view do
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    @group = assign(:group, build(:group,
                              id: 1,
                              name: "Name",
                              display_name: "Display Name"
                            ))
    allow(@group).to receive(:persisted?).and_return(true)
  end

  it "renders the edit group form" do
    render
    assert_select "form[action=?][method=?]", group_path(@group), "post" do
      assert_select "input[name=?]", "group[name]"
      assert_select "input[name=?]", "group[display_name]"
    end
  end
end

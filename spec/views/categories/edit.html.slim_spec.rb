# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  before(:each) do
    @category = assign(:category, build(:category,
                                        id: 1,
                                        name: "Name",
                                        display_name: "Display Name",
                                        title: "Title"
    ))
    allow(@category).to receive(:persisted?).and_return(true)
  end

  it "renders the edit category form" do
    render
    assert_select "form[action=?][method=?]", category_path(@category), "post" do
      assert_select "input[name=?]", "category[name]"
      assert_select "input[name=?]", "category[display_name]"
      assert_select "input[name=?]", "category[title]"
    end
  end
end

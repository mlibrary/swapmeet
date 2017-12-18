# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "categories/new", type: :view do
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    assign(:category, build(:category,
                            name: "Name",
                            display_name: "Display Name",
                            title: "Title"
    ))
  end

  it "renders new category form" do
    render
    assert_select "form[action=?][method=?]", categories_path, "post" do
      assert_select "input[name=?]", "category[name]"
      assert_select "input[name=?]", "category[display_name]"
      assert_select "input[name=?]", "category[title]"
    end
  end
end

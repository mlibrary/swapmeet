# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "publishers/new", type: :view do
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    assign(:publisher, build(:publisher,
                         name: "Name",
                         display_name: "Display Name"
                       ))
  end

  it "renders new publisher form" do
    render
    assert_select "form[action=?][method=?]", publishers_path, "post" do
      assert_select "input[name=?]", "publisher[name]"
      assert_select "input[name=?]", "publisher[display_name]"
    end
  end
end

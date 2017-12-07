# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "domains/new", type: :view do
  before(:each) do
    assign(:domain, build(:domain,
                      name: "Name",
                      display_name: "Display Name",
                      parent: nil
                    ))
  end

  it "renders new domain form" do
    render
    assert_select "form[action=?][method=?]", domains_path, "post" do
      assert_select "input[name=?]", "domain[name]"
      assert_select "input[name=?]", "domain[display_name]"
      assert_select "input[name=?]", "domain[parent]"
    end
  end
end

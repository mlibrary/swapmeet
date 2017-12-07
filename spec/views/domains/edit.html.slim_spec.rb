# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "domains/edit", type: :view do
  before(:each) do
    @domain = assign(:domain, Domain.create!(
                                name: "Name",
                                display_name: "MyString",
                                parent: nil
                              ))
  end

  it "renders the edit domain form" do
    render

    assert_select "form[action=?][method=?]", domain_path(@domain), "post" do

      assert_select "input[name=?]", "domain[name]"

      assert_select "input[name=?]", "domain[display_name]"

      assert_select "input[name=?]", "domain[parent]"
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "publishers/edit", type: :view do
  before(:each) do
    @publisher = assign(:publisher, build(:publisher,
                                      id: 1,
                                      name: "Name",
                                      display_name: "Display Name"
                                    ))
    allow(@publisher).to receive(:persisted?).and_return(true)
  end

  it "renders the edit publisher form" do
    render

    assert_select "form[action=?][method=?]", publisher_path(@publisher), "post" do

      assert_select "input[name=?]", "publisher[name]"

      assert_select "input[name=?]", "publisher[display_name]"
    end
  end
end

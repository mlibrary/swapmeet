# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "newspapers/new", type: :view do
  let(:publisher) { build(:publisher) }
  before(:each) do
    assign(:newspaper, build(:newspaper,
                         name: "Name",
                         display_name: "Display Name",
                         publisher: publisher
                       ))
  end

  it "renders new newspaper form" do
    render
    assert_select "form[action=?][method=?]", newspapers_path, "post" do
      assert_select "input[name=?]", "newspaper[name]"
      assert_select "input[name=?]", "newspaper[display_name]"
      assert_select "input[name=?]", "newspaper[publisher_id]"
    end
  end
end

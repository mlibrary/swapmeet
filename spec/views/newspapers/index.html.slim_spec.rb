# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "newspapers/index", type: :view do
  let(:publisher) { create(:publisher) }

  before(:each) do
    assign(:newspapers, [
      Newspaper.create!(
        name: "Name",
        display_name: "Display Name",
        publisher: publisher
      ),
      Newspaper.create!(
        name: "Name",
        display_name: "Display Name",
        publisher: publisher
      )
    ])
  end

  it "renders a list of newspapers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Display Name".to_s, count: 2
    assert_select "tr>td", text: publisher.to_s, count: 2
  end
end

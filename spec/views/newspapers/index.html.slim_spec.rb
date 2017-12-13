# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "newspapers/index", type: :view do
  let(:publisher) { create(:publisher) }

  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    assign(:newspapers, [
      build(:newspaper,
        id: 1,
        name: "Name",
        display_name: "Display Name",
        publisher: publisher
      ),
      build(:newspaper,
        id: 2,
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
    assert_select "tr>td", text: publisher.display_name.to_s, count: 2
  end
end

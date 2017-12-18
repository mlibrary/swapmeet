# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "listings/edit", type: :view do
  let(:category) { build(:category) }
  let(:newspaper) { build(:newspaper) }
  before(:each) do
    @listing = assign(:listing, build(:listing,
                                      id: 1,
                                      title: "Title",
                                      body: "Body",
                                      category: category,
                                      newspaper: newspaper
                                    ))
    allow(@listing).to receive(:persisted?).and_return(true)
  end

  it "renders the edit listing form" do
    render
    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do
      assert_select "select[name=?]", "listing[category_id]"
      assert_select "input[name=?]", "listing[title]"
      assert_select "input[name=?]", "listing[body]"
      assert_select "select[name=?]", "listing[newspaper_id]"
    end
  end
end

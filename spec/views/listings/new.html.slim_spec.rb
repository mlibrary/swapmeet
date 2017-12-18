# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "listings/new", type: :view do
  let(:category) { build(:category) }
  let(:newspaper) { build(:newspaper) }
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    assign(:listing, build(:listing,
                            title: "Title",
                            body: "Body",
                            category: category,
                            newspaper: newspaper
                          ))
  end

  it "renders new listing form" do
    render
    assert_select "form[action=?][method=?]", listings_path, "post" do
      assert_select "select[name=?]", "listing[category_id]"
      assert_select "input[name=?]", "listing[title]"
      assert_select "input[name=?]", "listing[body]"
      assert_select "select[name=?]", "listing[newspaper_id]"
    end
  end
end

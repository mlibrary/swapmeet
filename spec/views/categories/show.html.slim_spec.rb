# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    @category = assign(:category, build(:category,
                                        id: 1,
                                        name: "Name",
                                        display_name: "Display Name",
                                        title: "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Display Name/)
    expect(rendered).to match(/Title/)
  end
end

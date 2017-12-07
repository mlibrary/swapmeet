# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "gatekeepers/show", type: :view do
  before(:each) do
    @gatekeeper = assign(:gatekeeper, build(:gatekeeper,
                                        id: 1,
                                        role: "Role",
                                        domain: nil,
                                        group: nil,
                                        listing: nil,
                                        newspaper: nil,
                                        publisher: nil,
                                        user: nil
                                      ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Role/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end

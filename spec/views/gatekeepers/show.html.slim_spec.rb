# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "gatekeepers/show", type: :view do
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    @gatekeeper = assign(:gatekeeper, build(:gatekeeper,
                                        id: 1,
                                        role: "role",
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
    expect(rendered).to match(/role/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end

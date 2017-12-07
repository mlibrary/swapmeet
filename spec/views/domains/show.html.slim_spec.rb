# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "domains/show", type: :view do
  before(:each) do
    @domain = assign(:domain, build(:domain,
                                id: 1,
                                name: "Name",
                                display_name: "Display Name",
                                parent: nil
                              ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Display Name/)
    expect(rendered).to match(//)
  end
end

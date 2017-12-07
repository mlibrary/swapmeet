# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "publishers/show", type: :view do
  before(:each) do
    @publisher = assign(:publisher, build(:publisher,
                                      id: 1,
                                      name: "Name",
                                      display_name: "Display Name"
                                    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Display Name/)
  end
end

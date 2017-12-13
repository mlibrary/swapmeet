# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "groups/show", type: :view do
  before(:each) do
    @policy = ControllersHelper::AuthorizePolicy.new
    @group = assign(:group, build(:group,
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

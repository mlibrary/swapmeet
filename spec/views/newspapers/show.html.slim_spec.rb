# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "newspapers/show", type: :view do
  let(:publisher) { create(:publisher) }
  before(:each) do
    @newspaper = assign(:newspaper, Newspaper.create!(
                                      name: "Name",
                                      display_name: "Display Name",
                                      publisher: publisher
                                    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Display Name/)
    expect(rendered).to match(//)
  end
end

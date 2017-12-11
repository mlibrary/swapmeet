# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "newspapers/show", type: :view do
  let(:publisher) { build(:publisher, id: 1) }
  before(:each) do
    @newspaper = assign(:newspaper, build(:newspaper,
                                      id: 1,
                                      name: "Name",
                                      display_name: "Display Name",
                                      publisher: publisher
                                    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Display Name/)
    expect(rendered).to match(publisher.display_name)
  end
end

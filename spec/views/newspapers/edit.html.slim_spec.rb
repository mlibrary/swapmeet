# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "newspapers/edit", type: :view do
  let(:publisher) { build(:publisher) }

  before(:each) do
    @newspaper = assign(:newspaper, build(:newspaper,
                                      id: 1,
                                      name: "Name",
                                      display_name: "Display Name",
                                      publisher: publisher
                                    ))
    allow(@newspaper).to receive(:persisted?).and_return(true)
  end

  it "renders the edit newspaper form" do
    render

    assert_select "form[action=?][method=?]", newspaper_path(@newspaper), "post" do

      assert_select "input[name=?]", "newspaper[name]"

      assert_select "input[name=?]", "newspaper[display_name]"

      assert_select "input[name=?]", "newspaper[publisher_id]"
    end
  end
end

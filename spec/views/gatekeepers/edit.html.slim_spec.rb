# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "gatekeepers/edit", type: :view do
  let(:domain) { build(:domain, parent: nil) }
  let(:group) { build(:group) }
  let(:listing) { build(:listing) }
  let(:newspaper) { build(:newspaper) }
  let(:publisher) { build(:publisher) }
  let(:user) { build(:user) }

  before(:each) do
    controller.singleton_class.class_eval do
      protected
        def current_user
          User.guest
        end
        helper_method :current_user
    end
    @gatekeeper = assign(:gatekeeper, build(:gatekeeper,
                                        id: 1,
                                        role: "Role",
                                        domain: domain,
                                        group: group,
                                        listing: listing,
                                        newspaper: newspaper,
                                        publisher: publisher,
                                        user: user
                                      ))
    allow(@gatekeeper).to receive(:persisted?).and_return(true)
  end

  it "renders the edit gatekeeper form" do
    render
    assert_select "form[action=?][method=?]", gatekeeper_path(@gatekeeper), "post" do
      assert_select "input[name=?]", "gatekeeper[role]"
      assert_select "select[name=?]", "gatekeeper[domain_id]"
      assert_select "select[name=?]", "gatekeeper[group_id]"
      assert_select "select[name=?]", "gatekeeper[listing_id]"
      assert_select "select[name=?]", "gatekeeper[newspaper_id]"
      assert_select "select[name=?]", "gatekeeper[publisher_id]"
      assert_select "select[name=?]", "gatekeeper[user_id]"
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "gatekeepers/new", type: :view do
  before(:each) do
    controller.singleton_class.class_eval do
      protected
        def current_user
          User.guest
        end
        helper_method :current_user
    end
    @policy = ControllersHelper::AuthorizePolicy.new
    assign(:gatekeeper, build(:gatekeeper,
                          role: "Role",
                          domain: nil,
                          group: nil,
                          listing: nil,
                          newspaper: nil,
                          publisher: nil,
                          user: nil
                        ))
  end

  it "renders new gatekeeper form" do
    render
    assert_select "form[action=?][method=?]", gatekeepers_path, "post" do
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

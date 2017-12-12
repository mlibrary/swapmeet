# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "groups/index", type: :view do
  before(:each) do
    controller.singleton_class.class_eval do
      def the_user
        @the_user ||= User.new
      end

      protected

        def current_user
          the_user
        end

        helper_method :current_user
    end
    allow(controller.the_user).to receive(:id).and_return(1)
    assign(:groups, [
      build(:group,
        id: 1,
        name: "Name",
        display_name: "Display Name"
      ),
      build(:group,
        id: 2,
        name: "Name",
        display_name: "Display Name"
      )
    ])
  end

  it "renders a list of groups" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Display Name".to_s, count: 2
  end
end

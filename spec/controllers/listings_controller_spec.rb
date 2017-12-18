# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  context 'policy enforcement' do
    let(:user) { create(:user) }
    let(:category) { create(:category, id: '1') }
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(Category).to receive(:find).with("1").and_return(category)
    end
    it_should_behave_like 'policy enforcer', :listing, :Listing, "body": "body", "category_id": "1", "title": "title"
  end
end

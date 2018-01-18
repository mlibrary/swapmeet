# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe ApplicationHelper do
  it { expect(helper).to be_a(ApplicationHelper) }

  describe 'user_display_name_link' do
    subject { helper.user_display_name_link(user) }

    context 'anonymous' do
      let(:user) { build(:user, display_name: display_name) }
      let(:display_name) { 'Display Name' }
      it { is_expected.to eq display_name }
    end

    context 'authenticated' do
      let(:user) { create(:user, display_name: display_name) }
      let(:display_name) { 'Display Name' }
      it { is_expected.to eq "<a href=\"/users/#{user.id}\">Display Name</a>" }
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#new' do
    context 'default' do
      subject { described_class.new }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a User
        expect(subject.username).to be_nil
        expect(subject.display_name).to be_nil
        expect(subject.email).to be_nil
      end
    end
    context 'create' do
      subject { create(:user, username: 'Username', display_name: 'Display Name', email: 'email@example.com') }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a User
        expect(subject.username).to eq 'Username'
        expect(subject.display_name).to eq 'Display Name'
        expect(subject.email).to eq 'email@example.com'
      end
    end
  end
end

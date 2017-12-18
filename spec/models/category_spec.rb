# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#new' do
    context 'default' do
      subject { Category.new }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Category
        expect(subject.name).to be_nil
        expect(subject.display_name).to be_nil
        expect(subject.title).to be_nil
      end
    end
    context 'build' do
      subject { create(:category, name: 'build_name', display_name: 'build_display_name', title: 'build_title') }
      it do
        is_expected.not_to be_nil
        is_expected.to be_a Category
        expect(subject.name).to eq 'build_name'
        expect(subject.display_name).to eq 'build_display_name'
        expect(subject.title).to eq 'build_title'
      end
    end
  end
end

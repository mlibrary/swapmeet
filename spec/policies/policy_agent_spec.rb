# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyAgent do
  let(:entity_type) { double('entity_type') }
  let(:entity) { double('entity') }

  describe '#client' do
    subject { described_class.new(entity_type, entity).client }
    context 'nil' do
      let(:entity) { nil }
      it { is_expected.to be nil }
    end
    context 'entity' do
      it { is_expected.to be entity }
    end
  end

  describe '#client_id' do
    subject { described_class.new(entity_type, entity).client_id }
    context 'nil' do
      let(:entity) { nil }
      it { is_expected.to be nil }
    end
    context 'entity' do
      it { is_expected.to eq entity.to_s }
      context 'respond_to?(:id)' do
        let(:id) { double('id') }
        before { allow(entity).to receive(:id).and_return(id) }
        it { is_expected.to be id }
      end
    end
  end

  describe "#client_type" do
    subject { described_class.new(entity_type, entity).client_type }
    context 'nil' do
      let(:entity_type) { nil }
      it { is_expected.to eq nil }
    end
    context 'entity_type' do
      it { is_expected.to eq entity_type.to_s }
    end
  end
end

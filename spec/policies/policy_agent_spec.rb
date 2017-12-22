# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyAgent do
  let(:entity_type) { double('entity_type') }
  let(:entity) { double('entity') }

  describe '#client_id' do
    subject { described_class.new(entity_type, entity).send(:client_id) }
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

  describe '#client_persisted?' do
    subject { described_class.new(entity_type, entity).send(:client_persisted?) }
    context 'nil' do
      let(:entity) { nil }
      it { is_expected.to be false }
    end
    context 'entity' do
      it { is_expected.to be false }
      context 'respond_to?(:persisted?)' do
        context 'transient' do
          before { allow(entity).to receive(:persisted?).and_return(false) }
          it { is_expected.to be false }
        end
        context 'persistent' do
          before { allow(entity).to receive(:persisted?).and_return(true) }
          it { is_expected.to be true }
        end
      end
    end
  end
end

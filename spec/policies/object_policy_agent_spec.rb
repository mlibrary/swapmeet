# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ObjectPolicyAgent do
  let(:entity_type) { double('entity type') }
  let(:entity) { double('entity') }

  describe '#owner' do
    subject { described_class.new(entity_type, entity).owner }
    context 'nil' do
      let(:entity) { nil }
      it { is_expected.to be nil }
    end
    context 'entity' do
      it { is_expected.to be nil }
      context 'respond_to?(:owner)' do
        let(:owner) { double('owner') }
        before { allow(entity).to receive(:owner).and_return(owner) }
        it { is_expected.to be owner }
      end
    end
  end
end

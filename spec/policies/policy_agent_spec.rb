# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyAgent do
  let(:agent) { PolicyAgent.new(client_type, client) }
  let(:type) { double('type') }
  let(:instance) { double('instance') }
  let(:persisted) { double('persisted') }
  let(:id) { double('id') }

  before do
    allow(instance).to receive(:persisted?).and_return(persisted)
    allow(instance).to receive(:id).and_return(id)
  end

  describe '#known?' do
    subject { agent.known? }
    let(:client_type) { type }

    context 'nil' do
      let(:client) { nil }
      it { is_expected.to be false }
    end
    context 'instance' do
      let(:client) { instance }
      context 'transient' do
        let(:persisted) { false }
        it { is_expected.to be false }
      end
      context 'persist' do
        let(:persisted) { true }
        it { is_expected.to be true }
      end
    end
  end

  describe '#root?' do
    subject { agent.root? }
    let(:client) { instance }

    context 'nil' do
      let(:client_type) { nil }
      it { is_expected.to be false }
    end
    context 'type' do
      let(:client_type) { type }
      it { is_expected.to be false }
      context 'User' do
        let(:client_type) { :User }
        it { is_expected.to be false }
        context 'id' do
          it { is_expected.to be false }
          context '1' do
            let(:id) { 1 }
            it { is_expected.to be true }
          end
        end
      end
    end
  end
end

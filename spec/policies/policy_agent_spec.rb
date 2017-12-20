# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PolicyAgent do
  let(:agent) { described_class.new(client_type, client) }
  let(:type) { double('type') }
  let(:instance) { double('instance') }
  let(:persisted) { double('persisted') }
  let(:id) { double('id') }
  let(:email) { double('email') }
  let(:administrators) { { application: application_administrators, platform: platform_administrators } }
  let(:application_administrators) { [] }
  let(:platform_administrators) { [] }

  before do
    allow(instance).to receive(:persisted?).and_return(persisted)
    allow(instance).to receive(:id).and_return(id)
    allow(instance).to receive(:email).and_return(email)
    allow(Rails.application.config).to receive(:administrators).and_return(administrators)
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

  describe '#owner' do
    subject { agent.owner }
    let(:client_type) { type }
    context 'nil' do
      let(:client) { nil }
      it { is_expected.to be nil }
    end
    context 'instance' do
      let(:client) { instance }
      context 'transient' do
        let(:persisted) { false }
        it { is_expected.to be nil }
      end
      context 'persist' do
        let(:persisted) { true }
        it { is_expected.to be nil }
      end
      context 'owner' do
        let(:owner) { double('owner') }
        before { allow(client).to receive(:owner).and_return(owner) }
        it { is_expected.to be owner }
      end
    end
  end

  describe '#application_administrator?' do
    subject { agent.application_administrator? }
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
        it { is_expected.to be false }
        context 'application administrator' do
          let(:application_administrators) { [email] }
          it { is_expected.to be true }
        end
        context 'platform administrator' do
          let(:platform_administrators) { [email] }
          it { is_expected.to be false }
        end
      end
    end
  end

  describe '#platform_administrator?' do
    subject { agent.platform_administrator? }
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
        it { is_expected.to be false }
        context 'application administrator' do
          let(:application_administrators) { [email] }
          it { is_expected.to be false }
        end
        context 'platform administrator' do
          let(:platform_administrators) { [email] }
          it { is_expected.to be true }
        end
      end
    end
  end
end

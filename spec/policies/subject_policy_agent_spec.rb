# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubjectPolicyAgent do
  let(:entity_type) { double('entity_type') }
  let(:entity) { double('entity') }

  describe '#known?' do
    subject { described_class.new(entity_type, entity).known? }
    context 'nil' do
      let(:entity) { nil }
      it { is_expected.to be false }
    end
    context 'entity' do
      it { is_expected.to be false }
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

  context 'administrators' do
    let(:email) { double('email') }
    let(:administrators) { { application: application_administrators, platform: platform_administrators } }
    let(:application_administrators) { [] }
    let(:platform_administrators) { [] }

    before { allow(Rails.application.config).to receive(:administrators).and_return(administrators) }

    describe '#application_administrator?' do
      subject { described_class.new(entity_type, entity).application_administrator? }
      context 'nil' do
        let(:entity) { nil }
        it { is_expected.to be false }
      end
      context 'entity' do
        it { is_expected.to be false }
        context 'transient' do
          before { allow(entity).to receive(:persisted?).and_return(false) }
          it { is_expected.to be false }
          context 'email' do
            before { allow(entity).to receive(:email).and_return(email) }
            it { is_expected.to be false }
            context 'application administrator' do
              let(:application_administrators) { [email] }
              it { is_expected.to be true }
            end
          end
        end
        context 'persistent' do
          before { allow(entity).to receive(:persisted?).and_return(true) }
          it { is_expected.to be false }
          context 'email' do
            before { allow(entity).to receive(:email).and_return(email) }
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
    end

    describe '#platform_administrator?' do
      subject { described_class.new(entity_type, entity).platform_administrator? }
      context 'nil' do
        let(:entity) { nil }
        it { is_expected.to be false }
      end
      context 'entity' do
        it { is_expected.to be false }
        context 'transient' do
          before { allow(entity).to receive(:persisted?).and_return(false) }
          it { is_expected.to be false }
          context 'email' do
            before { allow(entity).to receive(:email).and_return(email) }
            it { is_expected.to be false }
            context 'platform administrator' do
              let(:platform_administrators) { [email] }
              it { is_expected.to be true }
            end
          end
        end
        context 'persistent' do
          before { allow(entity).to receive(:persisted?).and_return(true) }
          it { is_expected.to be false }
          context 'email' do
            before { allow(entity).to receive(:email).and_return(email) }
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
  end
end

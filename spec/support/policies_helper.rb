# frozen_string_literal: true

module PoliciesHelper
end

RSpec.shared_examples 'application policy' do
  subject { described_class.new(subject_agent, object_agent) }

  let(:subject_agent) { double('subject agent') }
  let(:object_agent) { double('object agent') }

  it 'application policy' do
    is_expected.to be_a ApplicationPolicy
  end

  it 'aliases new?' do
    is_expected.to receive(:create?)
    subject.new?
  end

  it 'aliases edit?' do
    is_expected.to receive(:update?)
    subject.edit?
  end
end

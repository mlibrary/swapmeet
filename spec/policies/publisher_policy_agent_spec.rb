# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublisherPolicyAgent do
  subject { publisher_agent }

  let(:publisher_agent) { described_class.new(publisher) }
  let(:publisher) { double('publisher') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :Publisher.to_s }
  it { expect(subject.client_id).to eq publisher.to_s }
  it { expect(subject.client).to be publisher }
end

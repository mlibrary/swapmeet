# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewspaperPolicyAgent do
  subject { newspaper_agent }

  let(:newspaper_agent) { described_class.new(newspaper) }
  let(:newspaper) { double('newspaper') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :Newspaper.to_s }
  it { expect(subject.client_id).to eq newspaper.to_s }
  it { expect(subject.client).to be newspaper }
end

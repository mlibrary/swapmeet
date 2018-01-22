# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryPolicyAgent do
  subject { category_agent }

  let(:category_agent) { described_class.new(category) }
  let(:category) { double('category') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :Category.to_s }
  it { expect(subject.client_id).to eq category.to_s }
  it { expect(subject.client).to be category }
end

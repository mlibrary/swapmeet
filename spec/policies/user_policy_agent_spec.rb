# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicyAgent do
  subject { user_agent }

  let(:user_agent) { described_class.new(user) }
  let(:user) { double('user') }

  it { is_expected.to be_a(ObjectPolicyAgent) }
  it { expect(subject.client_type).to eq :User.to_s }
  it { expect(subject.client_id).to eq user.to_s }
  it { expect(subject.client).to be user }
end

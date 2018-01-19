# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, model) }
  let(:user) { double('user') }
  let(:policy) { double('policy') }
  let(:model) { double('model') }

  it { is_expected.not_to be_nil }
end

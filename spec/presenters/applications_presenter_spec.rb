# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationsPresenter do
  subject { presenter }

  let(:presenter) { described_class.new(user, policy, models, presenters) }
  let(:user) { double('user') }
  let(:policy) { double('policy') }
  let(:models) { double('models') }
  let(:presenters) { double('presenters') }

  it { is_expected.to be_a(described_class) }
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Channel do
  let(:connection) { double('connection') }
  let(:identifier) { double('identifier') }
  let(:params) { {} }
  let(:identifiers) { [] }
  before { allow(connection).to receive(:identifiers).and_return(identifiers) }
  subject { ApplicationCable::Channel.new(connection, identifier, params) }
  it { is_expected.to be_a(ApplicationCable::Channel) }
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Connection do
  let(:server) { double('server') }
  let(:env) { { 'HTTP_CONNECTION': nil } }
  let(:worker_pool) { double('worker_pool') }
  let(:logger) { double('logger') }
  let(:config) { double('config') }
  let(:log_tags) { [] }
  let(:event_loop) { double('event_loop') }
  before do
    allow(server).to receive(:worker_pool).and_return(worker_pool)
    allow(server).to receive(:logger).and_return(logger)
    allow(server).to receive(:config).and_return(config)
    allow(config).to receive(:log_tags).and_return(log_tags)
    allow(server).to receive(:event_loop).and_return(event_loop)
  end
  subject { ApplicationCable::Connection.new(server, env) }
  it { is_expected.to be_a(ApplicationCable::Connection) }
end

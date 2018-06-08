# frozen_string_literal: true

require "rails_helper"
require_relative '../support/checkpoint_helpers'

RSpec.describe "permitting an institution to a resource" do

  def checkpoint_permits?(user, action)
    Checkpoint::Query::ActionPermitted.new(user, action, Checkpoint::Resource.all,
                                           authority: Services.checkpoint).true?
  end

  def add_inst_network(inst:, network:, access:)
    @unique_id ||= 0
    @unique_id += 1
    range = IPAddr.new(network).to_range
    Keycard::DB[:aa_network].insert([@unique_id, nil, network, range.first.to_i, range.last.to_i,
                                     access.to_s, nil, inst, Time.now.utc, 'test', 'f'])
  end

  let(:request) { double(:request, username: nil) }
  let(:factory) { double('factory', for: request) }
  let(:action) { "view" }
  let(:user) { User.guest }

  before(:each) do
    add_inst_network(inst: 1, network: '10.0.1.0/24', access: "allow")
    add_inst_network(inst: 2, network: '10.0.2.0/24', access: "allow")
    new_permit(agent(type: 'dlpsInstitutionId', id: '1'),
               make_permission(action),
               all_resources).save

    allow(request).to receive(:client_ip)
      .and_return(client_ip)

    user.identity = Keycard::RequestAttributes.new(request, request_factory: factory)
  end

  after(:each) do
    Keycard::DB[:aa_network].delete
  end

  context "with an ip address mapping to an allowed institution" do
    let(:client_ip) { "10.0.1.1" }

    it "permits the user to view anything" do
      expect(checkpoint_permits?(user, action)).to be(true)
    end
  end

  context "with an ip address that does not map to an institution" do
    let(:client_ip) { "10.0.3.1" }

    it "does not permit the user to view anything" do
      expect(checkpoint_permits?(user, action)).to be(false)
    end
  end

  context "with an ip address that maps to an institution that is not allowed" do
    let(:client_ip) { "10.0.2.1" }

    it "does not permit the user to view anything" do
      expect(checkpoint_permits?(user, action)).to be(false)
    end
  end
end

# frozen_string_literal: true

class PolicyMaker
  attr_reader :requestor_agent

  def initialize(requestor_agent)
    @requestor_agent = requestor_agent
  end

  def permit!(subject, verb, object)
    return false unless PolicyResolver.new(requestor_agent, VerbPolicyAgent.new(:Policy, :permit), object).grant?
    return true if query(subject, verb, object).any?
    gatekeeper = Gatekeeper.new
    gatekeeper.subject_type = subject.client_type
    gatekeeper.subject_id = subject.client_id
    gatekeeper.verb_type = verb.client_type
    gatekeeper.verb_id = verb.client_id
    gatekeeper.object_type = object.client_type
    gatekeeper.object_id = object.client_id
    gatekeeper.save!
  end

  def revoke!(subject, verb, object)
    return false unless PolicyResolver.new(requestor_agent, VerbPolicyAgent.new(:Policy, :revoke), object).grant?
    return true unless query(subject, verb, object).any?
    query(subject, verb, object).first.destroy!
  end

  private

    def query(subject, verb, object)
      Gatekeeper.where("subject_type = ? AND subject_id = ? AND verb_type = ? AND verb_id = ? AND object_type = ? AND object_id = ?", subject.client_type, subject.client_id, verb.client_type, verb.client_id, object.client_type, object.client_id)
    end
end

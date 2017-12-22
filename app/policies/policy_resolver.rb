# frozen_string_literal: true

class PolicyResolver
  attr_reader :subject_agent
  attr_reader :verb_agent
  attr_reader :object_agent

  def initialize(subject_agent, verb_agent, object_agent)
    @subject_agent = subject_agent
    @verb_agent = verb_agent
    @object_agent = object_agent
  end

  def grant?
    return true if verb_agent.client_type == :Policy.to_s
    query.any?
  end

  private

    def query
      Gatekeeper.where("subject_type = ? AND subject_id = ? AND verb_type = ? AND verb_id = ? AND object_type = ? AND object_id = ?", subject_agent.client_type, subject_agent.client_id, verb_agent.client_type, verb_agent.client_id, object_agent.client_type, object_agent.client_id)
    end
end

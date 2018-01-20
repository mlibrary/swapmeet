# frozen_string_literal: true

class PolicyMaker
  # Agent
  AGENT_ANY = PolicyAgent.new(nil, nil)

  # Subject Agent
  SUBJECT_ANY = SubjectPolicyAgent.new(nil, nil)

  # Verb Agents
  VERB_ANY = VerbPolicyAgent.new(nil, nil)
  ACTION_ANY = ActionPolicyAgent.new(nil)
  POLICY_ANY = PolicyPolicyAgent.new(nil)
  POLICY_PERMIT = PolicyPolicyAgent.new(:permit)
  POLICY_REVOKE = PolicyPolicyAgent.new(:revoke)
  ROLE_ADMINISTRATOR = RolePolicyAgent.new(:administrator)

  # Object Agents
  OBJECT_ANY = ObjectPolicyAgent.new(nil, nil)
  USER_ANY = UserPolicyAgent.new(nil)
  LISTING_ANY = ListingPolicyAgent.new(nil)

  attr_reader :requestor

  def initialize(requestor)
    @requestor = requestor
  end

  def exist?(subject, verb, object)
    gatekeepers = query(subject, verb, object)
    gatekeepers.each do |gatekeeper|
      next if gatekeeper.subject_type != subject.client_type
      next if gatekeeper.subject_id != subject.client_id
      next if gatekeeper.verb_type != verb.client_type
      next if gatekeeper.verb_id != verb.client_id
      next if gatekeeper.object_type != object.client_type
      next if gatekeeper.object_id != object.client_id
      return true
    end
    false
  end

  def permit!(subject, verb, object)
    return false unless grant?(POLICY_PERMIT, object)
    return true if exist?(subject, verb, object)
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
    return false unless grant?(POLICY_REVOKE, object)
    gatekeepers = query(subject, verb, object)
    gatekeepers.each do |gatekeeper|
      next if gatekeeper.subject_type != subject.client_type
      next if gatekeeper.subject_id != subject.client_id
      next if gatekeeper.verb_type != verb.client_type
      next if gatekeeper.verb_id != verb.client_id
      next if gatekeeper.object_type != object.client_type
      next if gatekeeper.object_id != object.client_id
      gatekeeper.destroy!
      return true
    end
    true
  end

  private

    def grant?(policy, object)
      grant = false
      # grant ||= SubjectPolicyAgent.new(requestor.client_type, requestor.client).administrator?
      grant ||= PolicyResolver.new(requestor, PolicyMaker::ROLE_ADMINISTRATOR, object).grant?
      grant ||= PolicyResolver.new(requestor, policy, object).grant?
      grant
    end

    def query(subject, verb, object)
      Gatekeeper
        .where('subject_type is NULL or subject_type = "" or subject_type = ?', subject.client_type)
        .where('subject_id is NULL or subject_id = "" or subject_id = ?', subject.client_id)
        .where('verb_type is NULL or verb_type = "" or verb_type = ?', verb.client_type)
        .where('verb_id is NULL or verb_id = "" or verb_id = ?', verb.client_id)
        .where('object_type is NULL or object_type = "" or object_type = ?', object.client_type)
        .where('object_id is NULL or object_id = "" or object_id = ?', object.client_id)
    end
end

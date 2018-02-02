# frozen_string_literal: true

class UserPresenter < ApplicationPresenter
  delegate :add?, :remove?, to: :policy

  delegate :username, :display_name, :email, to: :model

  def label
    return model.display_name if model.display_name.present?
    'USER'
  end

  def listings?
    !model.listings.empty?
  end

  def listings
    ListingsPresenter.new(user, ListingPolicy.new([policy.subject_agent, policy.object_agent]), model.listings)
  end

  def publishers?
    !model.publishers.empty?
  end

  def publishers
    PublishersPresenter.new(user, PublishersPolicy.new([policy.subject_agent, policy.object_agent]), model.publishers)
  end

  def newspapers?
    !model.newspapers.empty?
  end

  def newspapers
    NewspapersPresenter.new(user, NewspapersPolicy.new([policy.subject_agent, policy.object_agent]), model.newspapers)
  end

  def groups?
    !model.groups.empty?
  end

  def groups
    GroupsPresenter.new(user, GroupsPolicy.new([policy.subject_agent, policy.object_agent]), model.groups)
  end

  def privilege?
    object_agent = PolicyMaker::OBJECT_ANY
    object_agent = policy.agents[-2] if policy.agents.count > 2
    PolicyMaker.exists?(policy.object_agent, PolicyMaker::ROLE_ADMINISTRATOR, object_agent)
  end

  def privilege
    a = Privilege.new(
      id: 0,
      subject_type: policy.object_agent.client_type,
      subject_id: policy.object_agent.client_id,
      verb_type: PolicyMaker::ROLE_ADMINISTRATOR.client_type,
      verb_id: PolicyMaker::ROLE_ADMINISTRATOR.client_id,
      object_type: PolicyMaker::OBJECT_ANY.client_type,
      object_id: PolicyMaker::OBJECT_ANY.client_id
    )
    b = privileges
    b.models.each do |model|
      next unless model.subject_type == a.subject_type
      next unless model.subject_id == a.subject_id
      next unless model.verb_type == a.verb_type
      next unless model.verb_id == a.verb_id
      # next unless model.object_type == a.object_type
      # next unless model.object_id == a.object_id
      return PrivilegePresenter.new(user, PrivilegesPolicy.new(policy.agents.push(PrivilegePolicyAgent.new(model))), model)
    end
    # PrivilegePresenter.new(user, PrivilegesPolicy.new(policy.agents.push(PrivilegePolicyAgent.new(administrator))), administrator)
    nil
  end

  def privileges?
    !privileges.empty?
  end

  def privileges
    @privileges_presenter ||= PrivilegesPresenter.new(user, PrivilegesPolicy.new(policy.agents.push(PrivilegePolicyAgent.new(nil))), Privilege.all)
    # PrivilegesPresenter.new(user, PrivilegesPolicy.new(policy.agents.push(PrivilegePolicyAgent.new(nil))), Privilege.all)
  end

  def user?
    return false unless policy.agents.count > 2
    policy.agents[-2].client.users.exists?(policy.object_agent.client.id)
  end
end

# frozen_string_literal: true

class PublisherUserPresenter < UserPresenter
  delegate :privilege?, :user?, :add?, :remove?, to: :policy

  def privilege
    # if object.present?
    #   PrivilegePresenter.new(user, PrivilegesPolicy.new(policy.subject, object.policy.object), object.model)
    # else
    #   PrivilegePresenter.new(user, PrivilegesPolicy.new(policy.subject, policy.object), model)
    # end
    PublisherUserPrivilegePresenter.new(
      user,
      PublisherUserPrivilegesPolicy.new([
        policy.subject_agent,
        policy.publisher_agent,
        policy.user_agent,
        policy.object_agent]),
      model)
  end

  # def privilege?(object = nil)
  #   publisher = publisher_agent.client
  #   return true if publisher.present?
  #   false
  # end

  # def privilege?
  #   if object.present?
  #     PolicyMaker.exists?(policy.object, PolicyMaker::ROLE_ADMINISTRATOR, object.policy.object)
  #   else
  #     PolicyMaker.exists?(policy.object, PolicyMaker::ROLE_ADMINISTRATOR, PolicyMaker::OBJECT_ANY)
  #   end
  # end
  #
  def privilege
    PublisherUserPrivilegePresenter.new(user, PublisherUserPrivilegesPolicy.new([policy.subject_agent, policy.publisher_agent, policy.object_agent, PrivilegePolicyAgent.new(model)]), model)
  end
end

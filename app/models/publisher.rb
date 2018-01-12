# frozen_string_literal: true

class Publisher < ApplicationRecord
  belongs_to :domain, optional: true
  has_many :newspapers
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :users

  def administrator?(user)
    policy_resolver = PolicyResolver.new(
      SubjectPolicyAgent.new(:User, user),
      VerbPolicyAgent.new(:Role, :administrator),
      ObjectPolicyAgent.new(:Publisher, self)
    )
    policy_resolver.grant?
  end

  def user?(user)
    users.exists?(user.id)
  end
end

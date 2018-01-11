# frozen_string_literal: true

class Newspaper < ApplicationRecord
  belongs_to :publisher
  has_many :listings
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :users

  def administrator?(user)
    policy_resolver = PolicyResolver.new(
      SubjectPolicyAgent.new(:User, user),
      VerbPolicyAgent.new(:Role, :administrator),
      ObjectPolicyAgent.new(:Newspaper, self)
    )
    policy_resolver.grant?
  end

  def user?(user)
    users.exists?(user.id)
  end
end

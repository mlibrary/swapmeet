# frozen_string_literal: true

class User < ApplicationRecord
  has_many :listings, foreign_key: :owner

  attr_accessor :identity

  def self.nobody
    new(username: '<nobody>', display_name: '(No one)', email: '').tap(&:readonly!)
  end

  def self.guest
    new(username: '<guest>', display_name: 'Guest', email: '').tap(&:readonly!)
  end

  def known?
    persisted?
  end

  def has_role?(role, resource: nil)
    # This is a little ugly -- probably want to set up named params on the query classes
    # and pass ours along.. Alternatively, we could extra-specify that it's Resource.all... yuck.
    if resource
      Checkpoint::Query::RoleGranted.new(self, role, resource, authority: authority).true?
    else
      Checkpoint::Query::RoleGranted.new(self, role, authority: authority).true?
    end
  end

  def root?
    id == 1
  end

  def agent_type
    'user'
  end

  def agent_id
    username
  end

  private

    def authority
      Services.checkpoint
    end
end

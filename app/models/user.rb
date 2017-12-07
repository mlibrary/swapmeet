# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :groups

  def self.nobody
    new(username: '<nobody>', display_name: '(No one)', email: '').tap(&:readonly!)
  end

  def self.guest
    user = new(username: '<guest>', display_name: 'Guest', email: '').tap(&:readonly!)
  end

  def known?
    persisted?
  end
end

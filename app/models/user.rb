# frozen_string_literal: true

class User < ApplicationRecord
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

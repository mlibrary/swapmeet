# frozen_string_literal: true

class User < ApplicationRecord
  def self.nobody
    new(username: '<nobody>', display_name: '(No one)', email: '').tap(&:readonly!)
  end
end

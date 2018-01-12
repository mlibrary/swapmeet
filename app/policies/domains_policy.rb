# frozen_string_literal: true

class DomainsPolicy < ApplicationPolicy
  def index?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    true
  end

  def show?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    true
  end
end

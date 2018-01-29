# frozen_string_literal: true

class NewspaperUsersPolicy < ApplicationPolicy
  def index?
    return true if @subject.administrator?
    return false unless @subject.client_type == :User.to_s
    return false unless @subject.authenticated?
    return false unless @object.client_type == :Newspaper.to_s
    return false unless @object.client_id.present?
    @object.client.users.exists?(@subject.client_id)
  end
end

# frozen_string_literal: true

class GroupEditor < ApplicationEditor
  attr_reader :groups

  def initialize(user, policy, model)
    super(user, policy, model)
    @groups = Group.all.map { |group| [group.display_name, group.id] }
  end

  delegate :name, :display_name, :parent, :children, :users, :publishers, :newspapers, to: :model

  def parent?
    parent.present?
  end

  def children?
    children.empty?
  end

  def users?
    users.empty?
  end

  def publishers?
    publishers.empty?
  end

  def newspapers?
    newspapers.empty?
  end
end

# frozen_string_literal: true

require 'ostruct'
require 'vizier/presenter_factory'
require 'vizier/resource_presenter'

# Example of inheriting to take advantage of auto-presentation

# This would be some resource/model class; these are just fakes.
class SomeResource
  attr_reader :name, :other_resource

  def initialize(name, other_resource)
    @name = name
    @other_resource = other_resource
  end
end

# Another resource/model, here to demonstrate auto-presentation of associated
# objects.
class OtherResource
  attr_reader :title

  def initialize(title)
    @title = title
  end
end

# This would be a resource-oriented policy (governing CRUD/REST actions)
# It would probably inherit from a convenience class for delegating.
# For this example, creating a SomeResource is allowed unconditionally.
class SomeResourcePolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def create?
    true
  end
end

# This would be the policy for another type. In this example editing an
# OtherResource is prohibited unconditionally.
class OtherResourcePolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def edit?
    false
  end
end

# This would be the base resource presenter for your application.
# It provides your configured factory (mapping types to presenters/policies)
# to all inheriting presenters for auto-presentation of associated objects.
# The factory should be built in an initializer and made available with
# a service locator (class method) or IoC container.
# This base class is similar in purpose to ApplicationRecord.
class AppResourcePresenter < Vizier::ResourcePresenter
  protected

    def presenter_factory
      FakePresenterFactory.instance
    end
end

# This would be a specific presenter for the resource type.
# Note that it calls `present` with the associated object, which invokes
# the factory for presenting the object according to the default mapping,
# without needing to know the types or constructing the presenter/policy.
class SomeResourcePresenter < AppResourcePresenter
  def name
    resource.name.upcase
  end

  def other_resource
    present(resource.other_resource)
  end

  # Delegate permission checks to the policy
  def create?
    policy.create?
  end
end

class OtherResourcePresenter < AppResourcePresenter
  def short_title
    title[0..5] + '...'
  end

  # Delegate permission checks to the policy
  def edit?
    policy.edit?
  end
end

# This is the fake service locator. This would work in a real app, but using
# a minimal IoC container like Canister is recommended.
module FakePresenterFactory
  # This is the mapping of types to the presenters and policies that should be
  # used by default. The PRESENTERS name is not special; it would probably be
  # defined in an initializer or Ruby config file and passed to the
  # PresenterFactory constructor. A naming convention of appending Presenter or
  # Policy after the resource type name is followed here, but need not be. If an
  # object's class (or its string equivalent) is not mapped, the fall-through
  # default is to use a Vizier::NullPresenter and a Vizier::ReadOnlyPolicy.
  PRESENTERS = {
    SomeResource  => [SomeResourcePresenter, SomeResourcePolicy],
    OtherResource => [OtherResourcePresenter, OtherResourcePolicy]
  }

  class << self
    def instance
      @factory ||= Vizier::PresenterFactory.new(PRESENTERS)
    end
  end
end

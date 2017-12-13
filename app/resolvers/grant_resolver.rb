require 'subject_resolver'
require 'credential_resolver'
require 'resource_resolver'

class GrantResolver
  attr_reader :user, :action, :target
  def initialize(user, action, target)
    @user = user
    @action = action
    @target = target
  end

  def any?
    if user.username == 'anna'
      true
    else
      false
    end
  end

    # subjects = SubjectResolver.new(user)
    # ['user:gkostin', 'affiliation:lib-staff']
    # credentials = CredentialResolver.new(:destroy)
    # ['permission:destroy']
    # resources = ResourceResolver.new(listing)
    # ['listing:12', 'type:listing']
end

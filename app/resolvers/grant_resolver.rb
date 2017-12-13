require 'subject_resolver'
require 'credential_resolver'
require 'resource_resolver'

class GrantResolver
  attr_reader :user, :action, :target, :grants
  attr_writer :subject_resolver, :credential_resolver, :resource_resolver

  def initialize(user, action, target)
    @user = user
    @action = action
    @target = target
    # @grants = [
    #   ['user:gkostin', 'permission:edit', 'listing:2777'],
    #   ['role:editor', 'permission:edit', 'type:listing']
    # ]
  end

  def any?
    # Grant.where(subject: subjects, credential: credentials, resource: resources)
    # SELECT * FROM grants
    # WHERE subject IN('user:gkostin')
    # AND credential IN('permission:edit')
    # AND resource IN('listing:12', 'type:listing')

    grants.any?
  end

  private

    def grants
      if action == :edit && user.username == 'anna'
        [['user:anna', 'permission:edit', 'listing:12']]
      elsif action == :read && user.known?
        [[subjects.first, 'permission:read', 'listing:12']]
      else
        []
      end
    end

    def subjects
      # ['user:gkostin', 'affiliation:lib-staff']
      subject_resolver.resolve
    end

    def credentials
      # ['permission:destroy']
      credential_resolver.resolve
    end

    def resources
      # ['listing:12', 'type:listing']
      resource_resolver.resolve
    end

    def subject_resolver
      @subject_resolver ||= SubjectResolver.new(user)
    end

    def credential_resolver
      @credential_resolver ||= CredentialResolver.new(action)
    end

    def resource_resolver
      @resource_resolver ||= ResourceResolver.new(target)
    end
end

# frozen_string_literal: true

module PolicyHelpers
  protected

    def can?(action, agent: user, resource: Checkpoint::Resource.all)
      Checkpoint::Query::ActionPermitted.new(user, action, resource, authority: authority).true?
    end

    def authority
      Services.checkpoint
    end
end

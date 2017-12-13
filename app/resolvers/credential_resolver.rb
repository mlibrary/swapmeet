class CredentialResolver
  attr_reader :action

  def initialize(action)
    @action = action.to_sym
  end

  def resolve
    case action
    when :edit
      'permission:edit'
    when :read
      'permission:read'
    end
  end
end

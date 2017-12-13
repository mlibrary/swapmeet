class SubjectResolver
  def initialize(user)
    @user = user
  end

  def resolve
    tokens = [user_token]
    tokens += affiliation_tokens
    tokens
  end

  private

  def user_token
    "user:#{@user.username}"
  end

  def affiliation_tokens
    case user_token
    when 'user:bob'
      ['affiliation:lib-staff']
    when 'user:bill'
      ['affiliation:faculty']
    when 'user:jane'
      ['affiliation:lib-staff', 'affiliation:faculty']
    else
      []
    end
  end

end

class ResourceResolver
  attr_reader :target

  def initialize(target)
    @target = target
  end

  def resolve
    tokens = [entity_token]
    tokens << type_token
  end

  private

  def entity_token
    "#{target.entity_type}:#{target.id}"
  end

  def type_token
    "type:#{target.entity_type}"
  end
end

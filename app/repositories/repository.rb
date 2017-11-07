class Repository
  def self.register(type, repo)
    registry[type] = repo
  end

  def self.for(type)
    registry[type] or raise RepositoryNotFoundError
  end

  def self.registry
    @@registry ||= {}
  end
end

class RepositoryNotFoundError < StandardError; end

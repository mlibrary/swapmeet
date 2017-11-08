class Repository
  def self.register(type, repo)
    registry[type] = repo
  end

  def self.register_all(repositories)
    repositories.each do |type, repo|
      register type, repo
    end
  end

  def self.for(type)
    registry[type] or raise RepositoryNotFoundError
  end

  def self.registry
    @@registry ||= {}
  end
end

class RepositoryNotFoundError < StandardError; end

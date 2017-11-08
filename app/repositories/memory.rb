module MemoryRepository
  def self.repositories
    registry.clone
  end

  def self.register(type, repo)
    registry[type] = repo
  end

  private
  def self.registry
    @registry ||= {}
  end
end

require_relative 'memory/listing_repository'

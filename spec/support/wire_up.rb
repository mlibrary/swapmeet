require 'repository'
require 'memory'

MemoryRepository.repositories.each do |type, repo_class|
  Repository.register(type, repo_class.new)
end


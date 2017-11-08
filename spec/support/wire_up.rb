require 'repository'
require 'memory'

MemoryRepository.repositories.each do |type, repo|
  Repository.register(type, repo)
end


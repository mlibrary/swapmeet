require 'repository'
require 'memory'

Repository.register_all(MemoryRepository.repositories)


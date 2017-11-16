require 'repository'
require 'memory_repository'

Repository.register_all(MemoryRepository.repositories)


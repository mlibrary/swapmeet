require 'memory'

Hash.new(MemoryRepository).tap do |families|
  families[:development] = MemoryRepository
  families[:testing] = MemoryRepository
end[Rails.env.to_sym].repositories.each do |type, repo_class|
  Repository.register(type, repo_class.new)
end

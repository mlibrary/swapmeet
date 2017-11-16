require 'repository'
require 'memory'

Repository.register_all(MemoryRepository.repositories)

module Swapmeet
  class << self
    def newspaper
      @newspaper ||= Newspaper.new
    end
  end
end

# frozen_string_literal: true

class ObjectPresenter
  def initialize(object)
    @object = object
  end

  def self.for_object(object)
    new(object)
  end

  def self.for_objects(objects)
    presenters = []
    objects.each do |object|
      presenters << self.for_object(object)
    end
    presenters
  end
end

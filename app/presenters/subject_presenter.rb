# frozen_string_literal: true

class SubjectPresenter
  def initialize(subject)
    @subject = subject
  end

  def self.for_subject(subject)
    new(subject)
  end

  def self.for_subjects(subjects)
    presenters = Array.new
    subjects.each do |subject|
      presenters << self.for_subject(subject)
    end
    presenters
  end
end

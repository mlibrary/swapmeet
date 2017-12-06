# frozen_string_literal: true

class SubjectAgent
  attr_reader :subject

  def initialize(subject)
    @subject = subject
  end

  delegate :id, to: :@subject
end

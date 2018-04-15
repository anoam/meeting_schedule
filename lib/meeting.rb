# frozen_string_literal: true

# Implements meeting entity
class Meeting
  attr_reader :title, :duration

  def initialize(title, duration)
    @title = title
    @duration = duration
  end

  def to_s
    "#{title} #{duration}min"
  end
end

# frozen_string_literal: true

class Scheduler
  # Cell to fill {Matrix}
  class Cell
    attr_reader :meetings

    # @return [Cell] cell with no meetings
    def self.empty
      new([])
    end

    # @param meetings [Array<Meeting>] meetings to schedule
    def initialize(meetings)
      @meetings = meetings
    end

    # @return [Integer] total duration for all meetings
    def duration
      @duration ||= meetings.inject(0) { |sum, meeting| sum + meeting.duration }
    end

    # @param new_meeting [Meeting]
    # @return [Cell] new cell, contains all current cell meeting and new_meeting
    def add(new_meeting)
      self.class.new(meetings.clone.push(new_meeting))
    end
  end

  private_constant :Cell
end

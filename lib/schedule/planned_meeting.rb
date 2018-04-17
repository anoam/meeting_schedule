# frozen_string_literal: true

class Schedule
  # Time slot for meeting
  class PlannedMeeting
    attr_reader :starts_at

    # Builds sequence of meetings
    # @param time_to_begin [TimeOfDay] time when meetings begin
    # @param meetings [Array<Meeting>] meetings for sequence
    # @return [Array<PlannedMeeting>] sequence of time slots
    def self.build_sequence(time_to_begin, meetings)
      result = []
      meetings.reduce(time_to_begin) do |beginning, meeting|
        result.push(new(beginning, meeting))
        beginning.minutes_later(meeting.duration)
      end

      result
    end

    # @param starts_at [TimeOfDay] time when meeting begins
    # @param meeting [Meeting] scheduled meeting
    def initialize(starts_at, meeting)
      @starts_at = starts_at
      @meeting = meeting
    end

    # @return [TimeOfDay] time when meeting ends
    def ends_at
      @ends_at ||= starts_at.minutes_later(meeting.duration)
    end

    # @return [String] string representation of slot
    def to_s
      "#{starts_at} #{meeting}"
    end

    # @return [Integer] total durat
    def duration
      meeting.duration
    end

    def title
      meeting.title
    end

    private

    attr_reader :meeting
  end
end

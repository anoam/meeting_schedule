# frozen_string_literal: true

require 'time_of_day'

class Schedule
  # Room for scheduling
  class Room
    # @param morning_meetings [Array<Meeting>] meetings for morning, for room
    # @param afternoon_meetings [Array<Meeting>] meetings for morning, for room
    def initialize(morning_meetings, afternoon_meetings)
      @morning_meetings = PlannedMeeting.build_sequence(MORNING_STARTS_AT, morning_meetings)
      @afternoon_meetings = PlannedMeeting.build_sequence(AFTERNOON_STARTS_AT, afternoon_meetings)
    end

    # @return [String] string representation of room
    def to_s
      <<~TEXT.strip
        #{morning_meetings.join("\n")}
        #{LUNCH_STARTS_AT} Lunch
        #{afternoon_meetings.join("\n")}
      TEXT
    end

    # @return [Array<PlannedMeeting>] all meetings in room
    def meetings
      @meetings ||= morning_meetings + afternoon_meetings
    end

    private

    attr_reader :morning_meetings, :afternoon_meetings
  end

  private_constant :Room
end

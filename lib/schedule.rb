# frozen_string_literal: true

require 'time_of_day'

# Schedule of meetings for day
class Schedule
  autoload :Room, "schedule/room"
  autoload :PlannedMeeting, "schedule/planned_meeting"

  MORNING_STARTS_AT = TimeOfDay.new(hours: 9).freeze
  AFTERNOON_STARTS_AT = TimeOfDay.new(hours: 13).freeze

  MORNING_SESSION_DURATION = 3 * TimeOfDay::MINUTES_PER_HOUR
  AFTERNOON_SESSION_DURATION = 4 * TimeOfDay::MINUTES_PER_HOUR

  LUNCH_STARTS_AT = TimeOfDay.new(hours: 12).freeze

  # @param first_room_morning_meetings [Array<Meeting>] meetings for morning, for first room
  # @param second_room_morning_meetings [Array<Meeting>] meetings for morning, for second room
  # @param first_room_afternoon_meetings [Array<Meeting>] meetings for afternoon, for first room
  # @param second_room_afternoon_meetings [Array<Meeting>] meetings for afternoon, for second room
  def initialize(first_room_morning_meetings, second_room_morning_meetings, first_room_afternoon_meetings, second_room_afternoon_meetings)
    @first_room = Room.new(first_room_morning_meetings, first_room_afternoon_meetings)
    @second_room = Room.new(second_room_morning_meetings, second_room_afternoon_meetings)
  end


  # @return [Array<PlannedMeeting>] all meetings at first room
  def first_room_meetings
    first_room.meetings
  end

  # @return [Array<PlannedMeeting>] all meetings at second room
  def second_room_meetings
    second_room.meetings
  end

  # @return [Array<PlannedMeeting>] all meetings of day
  def meetings
    @meetings ||= first_room_meetings + second_room_meetings
  end

  # @return [String] string representation of object
  def to_s
    <<~TEXT.strip
    Room 1:
    #{first_room}

    Room 2:
    #{second_room}
    TEXT
  end

  private
  attr_reader :first_room, :second_room
end

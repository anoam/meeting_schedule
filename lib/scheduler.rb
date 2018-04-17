# frozen_string_literal: true

require 'schedule'

# Provides creates schedule for given meetings
class Scheduler
  autoload :Matrix, 'scheduler/matrix'
  autoload :Cell, 'scheduler/cell'

  TooManyMeetings = Class.new(StandardError)

  # Assembles {Schedule} using given {Meeting}'s
  # @param meetings [Array<Meeting>] meetings to schedule
  # @return [Schedule] builded schedule
  # @raise [TooManyMeetings] if unable to schedule all meeting at one day
  def draw_up(meetings)
    check_total_duration!(meetings)

    first_morning_meetings = extract_period(meetings, morning_session_duration)
    meetings -= first_morning_meetings

    second_morning_meetings = extract_period(meetings, morning_session_duration)
    meetings -= second_morning_meetings

    first_afternoon_meetings = extract_period(meetings, afternoon_session_duration)
    second_afternoon_meetings = meetings - first_afternoon_meetings

    build_schedule(first_morning_meetings, second_morning_meetings, first_afternoon_meetings, second_afternoon_meetings)
  end

  private

  def extract_period(meetings, period)
    matrix = build_matrix(period)
    matrix.fill(meetings)

    matrix.solution
  end

  def check_total_duration!(meetings)
    day_duration = 2 * (morning_session_duration + afternoon_session_duration)
    total_meetings_duration = meetings.sum(&:duration)

    raise(TooManyMeetings, "Can't schedule all that meetings at one day") if total_meetings_duration > day_duration
  end

  def build_matrix(duration)
    Matrix.new(duration)
  end

  def morning_session_duration
    Schedule::MORNING_SESSION_DURATION
  end

  def afternoon_session_duration
    Schedule::AFTERNOON_SESSION_DURATION
  end

  def build_schedule(first_morning_meetings, second_morning_meetings, first_afternoon_meetings, second_afternoon_meetings)
    Schedule.new(first_morning_meetings, second_morning_meetings, first_afternoon_meetings, second_afternoon_meetings)
  end
end

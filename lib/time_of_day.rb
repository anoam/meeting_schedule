# frozen_string_literal: true

require 'invalid_data'

# Represents time of day
class TimeOfDay

  MINUTES_PER_HOUR = 60
  MINUTES_PER_DAY = 1440
  HOURS_PER_DAY = 24
  NOON_HOUR = 12

  # @param hours [Integer] number of complete hours of day
  # @param minutes [Integer] number of complete hours of hour
  # @raise [InvalidData] if given data is invalid
  def initialize(hours: 0, minutes: 0)
    raise(InvalidData, "invalid hours") if hours < 0
    raise(InvalidData, "invalid hours") if hours >= HOURS_PER_DAY
    raise(InvalidData, "invalid minutes") if minutes < 0
    raise(InvalidData, "invalid minutes") if minutes >= MINUTES_PER_HOUR

    @minute_of_day = hours * MINUTES_PER_HOUR + minutes
  end

  # Represents object as string
  # @return [String] string representation of object
  def to_s
    sprintf("%02d:%02d%s", hour, minutes, meridian_indicator)
  end

  # Compares object with other
  # @param other [TimeOfDay] object to compare
  # @Return [Boolean] false if other time is later, true otherwise
  def greater_or_eql?(other)
    minute_of_day >= other.minute_of_day
  end

  # Returns new time delta minutes later
  # @param diff [Integer] minutes to add to current time
  # @return [TimeOfDay]
  # @raise [InvalidData] if new time comes tomorrow
  def minutes_later(diff)
    new_minute_of_day = minute_of_day + diff
    raise(InvalidData, "day is over") if new_minute_of_day >= MINUTES_PER_DAY

    self.class.new.tap { |result| result.minute_of_day = new_minute_of_day }
  end

  protected

  attr_accessor :minute_of_day

  private

  def hour_of_day
    minute_of_day.div(MINUTES_PER_HOUR)
  end

  def hour
    return NOON_HOUR if hour_of_day == NOON_HOUR

    hour_of_day % NOON_HOUR
  end

  def minutes
    minute_of_day % MINUTES_PER_HOUR
  end

  def meridian_indicator
    if hour_of_day < NOON_HOUR
      "AM"
    else
      "PM"
    end
  end

end

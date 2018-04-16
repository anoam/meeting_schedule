# frozen_string_literal: true

require 'meeting'
require 'invalid_data'

# Provides {Meeting}s deserialization from string
class MeetingDeserializer
  MEETING_REGEXP = /(?<title>.+)\s(?<duration>\d+)min/

  # Restores collection of meetings from string
  # @param source [String] formatted string that contains serialized meetings
  #   one per line
  def restore(source)
    return [] if source.nil?
    return [] if source.empty?

    source.split("\n").map do |text_meeting|
      data = MEETING_REGEXP.match(text_meeting)
      raise(InvalidData, 'invalid format') if data.nil?

      Meeting.new(data[:title], data[:duration].to_i)
    end
  end
end

# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'
require 'meeting_deserializer'
require 'invalid_data'
require 'scheduler'

get '/' do
  erb :index
end

get '/schedule' do
  deserializer = MeetingDeserializer.new
  scheduler = Scheduler.new

  meetings = deserializer.restore(params[:raw_meetings].strip)
  scheduler.draw_up(meetings).to_s
rescue InvalidData, Scheduler::TooManyMeetings => e
  e.message
end

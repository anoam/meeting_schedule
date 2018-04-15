# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require 'sinatra'
require 'meeting_deserializer'
require 'invalid_data'

get '/' do
  erb :index
end

get '/schedule' do
  begin
    deserializer = MeetingDeserializer.new
    meetings = deserializer.restore(params[:raw_meetings].strip)
    meetings.join("\n")
  rescue InvalidData => e
    e.message
  end
end

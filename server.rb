# frozen_string_literal: true

require 'sinatra'

get '/' do
  erb :index
end

get '/schedule' do
  'hello'
end
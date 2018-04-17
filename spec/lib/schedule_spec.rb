# frozen_string_literal: true

require 'rspec'
require 'schedule'
require 'meeting'

describe Schedule do
  describe '#to_s' do
    let(:first_room_morning_meetings) do
      [
          Meeting.new('All Hands meeting', 60),
          Meeting.new('Marketing presentation', 30),
          Meeting.new('Product team sync', 30)
      ]
    end
    let(:second_room_morning_meetings) do
      [
          Meeting.new('Ruby vs Go presentation', 45),
          Meeting.new('New app design presentation', 45),
          Meeting.new('Customer support sync', 30)
      ]
    end
    let(:first_room_afternoon_meetings) do
      [
          Meeting.new('Front-end coding interview', 60),
          Meeting.new('Skype Interview A', 30),
          Meeting.new('Skype Interview B', 30)
      ]
    end
    let(:second_room_afternoon_meetings) do
      [
        Meeting.new('Project Bananaphone Kickoff', 45),
        Meeting.new('Developer talk', 60),
        Meeting.new('API Architecture planning', 45),
      ]
    end

    subject do
      Schedule.new(first_room_morning_meetings, second_room_morning_meetings, first_room_afternoon_meetings, second_room_afternoon_meetings)
        .to_s
    end

    it "returns string representation of schedule" do
      is_expected.to eql(<<~TEXT.strip)
      Room 1:
      09:00AM All Hands meeting 60min
      10:00AM Marketing presentation 30min
      10:30AM Product team sync 30min
      12:00PM Lunch
      01:00PM Front-end coding interview 60min
      02:00PM Skype Interview A 30min
      02:30PM Skype Interview B 30min

      Room 2:
      09:00AM Ruby vs Go presentation 45min
      09:45AM New app design presentation 45min
      10:30AM Customer support sync 30min
      12:00PM Lunch
      01:00PM Project Bananaphone Kickoff 45min
      01:45PM Developer talk 60min
      02:45PM API Architecture planning 45min
      TEXT
    end

  end

end

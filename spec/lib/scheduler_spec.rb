# frozen_string_literal: true

require 'rspec'
require 'scheduler'

describe Scheduler do

  subject { Scheduler.new }

  it 'creates schedule' do
    meetings = [Meeting.new('All Hands meeting', 60), Meeting.new('Marketing presentation', 30)]

    schedule = subject.draw_up(meetings)
    expect(schedule).to be_a(Schedule)

    expect(collisions?(schedule.first_room_meetings)).to be_falsey
    expect(collisions?(schedule.second_room_meetings)).to be_falsey
    expect(lunch_collisions?(schedule.meetings)).to be_falsey
    expect(early_meetings?(schedule.meetings)).to be_falsey
    expect(late_meetings?(schedule.meetings)).to be_falsey

    expect(include_all_meetings?(schedule.meetings, meetings)).to be_truthy
  end

  it 'creates another schedule' do
    meetings = [
        Meeting.new('All Hands meeting', 60),
        Meeting.new('Marketing presentation', 30),
        Meeting.new('Product team sync', 30),
        Meeting.new('Ruby vs Go presentation', 45),
        Meeting.new('New app design presentation', 45),
        Meeting.new('Customer support sync', 30),
        Meeting.new('Front-end coding interview', 60),
        Meeting.new('Skype Interview A', 30),
        Meeting.new('Skype Interview B', 30),
        Meeting.new('Project Bananaphone Kickoff', 45),
        Meeting.new('Developer talk', 60),
        Meeting.new('API Architecture planning', 45),
        Meeting.new('Android app presentation', 45),
        Meeting.new('Back-end coding interview A', 60),
        Meeting.new('Back-end coding interview B', 60),
        Meeting.new('Back-end coding interview C', 60),
        Meeting.new('Sprint planning', 45),
        Meeting.new('New marketing campaign presentation', 30)
    ]

    schedule = subject.draw_up(meetings)
    expect(schedule).to be_a(Schedule)

    expect(collisions?(schedule.first_room_meetings)).to be_falsey
    expect(collisions?(schedule.second_room_meetings)).to be_falsey
    expect(lunch_collisions?(schedule.meetings)).to be_falsey
    expect(early_meetings?(schedule.meetings)).to be_falsey
    expect(late_meetings?(schedule.meetings)).to be_falsey

    expect(include_all_meetings?(schedule.meetings, meetings)).to be_truthy
  end

  it 'raise error when too many meetings' do
    meetings = [
        Meeting.new('All Hands meeting', 60),
        Meeting.new('Marketing presentation', 30),
        Meeting.new('Product team sync', 30),
        Meeting.new('Ruby vs Go presentation', 45),
        Meeting.new('New app design presentation', 45),
        Meeting.new('Customer support sync', 30),
        Meeting.new('Front-end coding interview', 60),
        Meeting.new('Skype Interview A', 30),
        Meeting.new('Skype Interview B', 30),
        Meeting.new('Project Bananaphone Kickoff', 45),
        Meeting.new('Developer talk', 60),
        Meeting.new('API Architecture planning', 45),
        Meeting.new('Android app presentation', 45),
        Meeting.new('Back-end coding interview A', 60),
        Meeting.new('Back-end coding interview B', 60),
        Meeting.new('Back-end coding interview C', 60),
        Meeting.new('Sprint planning', 45),
        Meeting.new('New marketing campaign presentation', 30),
        Meeting.new('OVERLOADING MEETING', 60)
    ]

    expect { subject.draw_up(meetings) }.to raise_exception(Scheduler::TooManyMeetings)
  end

  def collisions?(meetings)
    meetings.combination(2).any? do |first, second|
      first_starts_after_second = first.starts_at.greater_or_eql?(second.ends_at)
      second_starts_after_first = second.starts_at.greater_or_eql?(first.ends_at)

      !first_starts_after_second && !second_starts_after_first
    end
  end

  def lunch_collisions?(meetings)
    lunch_begins = TimeOfDay.new(hours: 12)
    lunch_ends = TimeOfDay.new(hours: 13)

    meetings.any? do |meeting|
      ends_before_lunch = lunch_begins.greater_or_eql?(meeting.ends_at)
      starts_after_lunch = meeting.starts_at.greater_or_eql?(lunch_ends)

      !ends_before_lunch && !starts_after_lunch
    end
  end

  def early_meetings?(meetings)
    begin_of_business_day = TimeOfDay.new(hours: 9)

    meetings.any? do |meeting|
      !meeting.starts_at.greater_or_eql?(begin_of_business_day)
    end
  end

  def late_meetings?(meetings)
    end_of_business_day = TimeOfDay.new(hours: 17)

    meetings.any? do |meeting|
      ! end_of_business_day.greater_or_eql?(meeting.ends_at)
    end
  end

  def include_all_meetings?(schedule_meetings, meetings)
    meetings.all? do |expected|
      schedule_meetings.any? { |actual| actual.title.eql?(expected.title) && actual.duration.eql?(expected.duration) }
    end
  end

end

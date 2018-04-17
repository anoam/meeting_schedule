# frozen_string_literal: true

require 'rspec'
require 'time_of_day'

describe TimeOfDay do

  describe '#to_s' do
    it { expect(TimeOfDay.new.to_s).to eql("00:00AM") }
    it { expect(TimeOfDay.new(hours: 10).to_s).to eql("10:00AM") }
    it { expect(TimeOfDay.new(minutes: 30).to_s).to eql("00:30AM") }
    it { expect(TimeOfDay.new(hours: 12, minutes: 30).to_s).to eql("12:30PM") }
    it { expect(TimeOfDay.new(hours: 17, minutes: 30).to_s).to eql("05:30PM") }

    it { expect {TimeOfDay.new(hours: 24)}.to raise_error(InvalidData)}
    it { expect {TimeOfDay.new(hours: 25)}.to raise_error(InvalidData)}
    it { expect {TimeOfDay.new(hours: -1)}.to raise_error(InvalidData)}
    it { expect {TimeOfDay.new(minutes: -1)}.to raise_error(InvalidData)}
    it { expect {TimeOfDay.new(minutes: 60)}.to raise_error(InvalidData)}
    it { expect {TimeOfDay.new(minutes: 61)}.to raise_error(InvalidData)}
  end

  describe '#greater_or_eql?' do
    it { expect(TimeOfDay.new.greater_or_eql?(TimeOfDay.new(minutes: 10))).to be_falsey }
    it { expect(TimeOfDay.new(hours: 1).greater_or_eql?(TimeOfDay.new(minutes: 10))).to be_truthy }
    it { expect(TimeOfDay.new(hours: 10, minutes: 15).greater_or_eql?(TimeOfDay.new(hours: 10, minutes: 15))).to be_truthy }
  end

  describe '#minutes_later' do
    it { expect(TimeOfDay.new.minutes_later(10).to_s).to be_eql("00:10AM") }
    it { expect(TimeOfDay.new(hours: 1).minutes_later(30).to_s).to be_eql("01:30AM") }
    it { expect(TimeOfDay.new(hours: 12, minutes: 20).minutes_later(70).to_s).to be_eql("01:30PM") }

    it { expect { TimeOfDay.new(hours: 23, minutes: 50).minutes_later(11).to_s }.to raise_error(InvalidData) }
  end
end

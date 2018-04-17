# frozen_string_literal: true
require 'rspec'
require 'meeting_deserializer'

describe MeetingDeserializer do
  subject { MeetingDeserializer.new }

  it 'deserializes meeting' do
    result = subject.restore("All Hands meeting 60min")

    expect(result).to be_a(Array)
    expect(result.size).to eq(1)
    expect(result.first).to be_a(Meeting)
    expect(result.first.title).to eql("All Hands meeting")
    expect(result.first.duration).to eql(60)
  end

  it 'deserializes multiple meetings' do
    result = subject.restore(<<~TEXT.strip)
    New app design presentation 45min
    Customer support sync 30min
    TEXT

    expect(result).to be_a(Array)
    expect(result.size).to eq(2)
    expect(result.first).to be_a(Meeting)
    expect(result.first.title).to eql("New app design presentation")
    expect(result.first.duration).to eql(45)

    expect(result[1]).to be_a(Meeting)
    expect(result[1].title).to eql("Customer support sync")
    expect(result[1].duration).to eql(30)
  end

  it "returns empty array when empty string is given" do
    expect(subject.restore("")).to eq([])
  end

  it "returns empty array when empty nil is given" do
    expect(subject.restore(nil)).to eq([])
  end

  it "raises error on missing duration" do
    expect { subject.restore("Just a title") }.to raise_error(InvalidData)
  end

  it "raises error on invalid duration" do
    expect { subject.restore("Ruby vs Go presentation _5min") }.to raise_error(InvalidData)
  end

end

# frozen_string_literal: true

class Scheduler
  # matrix to find best solution
  class Matrix

    # @param duration [Integer] target duration
    def initialize(duration)
      @maximum_duration = duration
      @current_line = Array.new(duration + 1) { empty_cell }
      @solutions = [@current_line]
    end

    # Fills matrix with given meetings
    # @param meetings [Array<Meeting>] meetings to be distributed
    def fill(meetings)
      meetings.each do |meeting|
        add_line(meeting)
        break if perfect_solution_found?
      end
    end

    # @return [Array<Meeting>] set of meetings that have common duration as close to target as possible
    def solution
      current_line.last.meetings
    end

    private

    attr_reader :maximum_duration, :solutions
    attr_accessor :current_line

    def perfect_solution_found?
      cell = current_line.last
      cell.duration == maximum_duration
    end

    def duration_variations
      @duration_variations ||= 1..maximum_duration
    end

    def add_line(meeting)
      new_line = [empty_cell]

      duration_variations.each do |intermediate_duration|
        if meeting.duration > intermediate_duration
          new_line.push(current_line[intermediate_duration])
          next
        end

        if current_line[intermediate_duration].duration > current_line[intermediate_duration - meeting.duration].duration + meeting.duration
          new_line.push(current_line[intermediate_duration])
        else
          new_line.push(current_line[intermediate_duration - meeting.duration].add(meeting))
        end
      end

      self.current_line = new_line
      solutions.push(current_line)
    end

    def empty_cell
      Cell.empty
    end
  end

  private_constant :Matrix
end

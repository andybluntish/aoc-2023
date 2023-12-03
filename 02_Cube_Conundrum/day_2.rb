#!/usr/bin/env ruby -w

module Day2
  module Part1
    def self.run(input)
      input.split("\n").map do |line|
        game = Game.new(line)
        game.possible? ? game.id : 0
      end.sum
    end
  end

  module Part2
    def self.run(input)
      input.split("\n").map do |line|
        Game.new(line).power
      end.sum
    end
  end

  private

  class Game
    def initialize(input)
      _, id, rounds = *input.match(/Game (\d+):\s(.*)/)

      @id = id.to_i
      @rounds = rounds.split(";").map do |round|
        results = {}
        round.split(",").each do |result|
          _, score, colour = *result.match(/(\d+)\s(\w+)/)
          results[colour.to_sym] = score.to_i
        end
        results
      end
    end

    attr_reader :id, :rounds

    def possible?
      possible = true
      @rounds.each do |round|
        round.each do |colour, score|
          possible = score <= MAX_SCORES[colour]
          break unless possible
        end
        break unless possible
      end
      possible
    end

    def power
      counts = {red: 0, green: 0, blue: 0}
      @rounds.map do |round|
        round.map do |colour, score|
          counts[colour] = score if score > counts[colour]
        end
      end
      counts.values.inject(:*)
    end

    private

    MAX_SCORES = {
      red: 12,
      green: 13,
      blue: 14
    }
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, "input.txt"))
  puts Day2::Part1.run(input)
  puts Day2::Part2.run(input)
end

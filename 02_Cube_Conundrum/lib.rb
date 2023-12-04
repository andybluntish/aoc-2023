#!/usr/bin/env ruby -w

module Day02
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
      @results = rounds.split(/[;,]/).map do |round|
        _, score, colour = *round.match(/(\d+)\s(\w+)/)
        [colour.to_sym, score.to_i]
      end
    end

    attr_reader :id

    def possible?
      @results.all? do |colour, score|
        score <= MAX_SCORES[colour]
      end
    end

    def power
      @results.each_with_object(Hash.new(0)) do |round, scores|
        colour, score = round
        scores[colour] = score if score > scores[colour]
      end.values.inject(:*)
    end

    private

    MAX_SCORES = {red: 12, green: 13, blue: 14}
  end
end

#!/usr/bin/env ruby -w

module Day04
  module Part1
    def self.run(input)
      Day04.parse(input).map do |card|
        score = Day04.card_score(card)
        score.positive? ? 2**(score - 1) : 0
      end.sum
    end
  end

  module Part2
    def self.run(input)
      cards = Day04.parse(input).map do |card|
        {count: 1, score: Day04.card_score(card)}
      end

      cards.each_with_index do |card, index|
        cards.slice(index + 1, card[:score]).each do |c|
          c[:count] += card[:count]
        end
      end

      cards.map { |card| card[:count] }.sum
    end
  end

  class << self
    def parse(input)
      input.split("\n").map do |line|
        line.split(":").last.split("|").map { |d| d.scan(/\d+/).map(&:to_i) }
      end
    end

    def card_score(card)
      winning, game = card
      game.count { |n| winning.include?(n) }
    end
  end
end

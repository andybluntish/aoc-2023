#!/usr/bin/env ruby -w

module Day1
  module Part1
    def self.run(input)
      input.split("\n").map do |line|
        digits = line.scan(/\d/)
        [digits.first, digits.last].join.to_i
      end.sum
    end
  end

  module Part2
    def self.run(input)
      regex = Regexp.new("(?=(#{(DIGITS + WORD_DIGITS).join("|")}))")
      digits = input.split("\n").map do |line|
        digits = line.scan(regex).flatten.map { |d| to_digits(d) }
        [digits.first, digits.last].join.to_i
      end.sum
    end

    private

    DIGITS = %w[1 2 3 4 5 6 7 8 9].freeze
    WORD_DIGITS = %w[one two three four five six seven eight nine].freeze

    class << self
      def to_digits(str)
        str = DIGITS[WORD_DIGITS.index(str)] unless DIGITS.include?(str)
        str
      end
    end
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, "input.txt"))
  puts Day1::Part1.run(input)
  puts Day1::Part2.run(input)
end

#!/usr/bin/env ruby -w

module Day03
  module Part1
    def self.run(input)
      Day03.find_parts_numbers(input).flatten.compact.map(&:value).sum
    end
  end

  module Part2
    def self.run(input)
      lines, width, height = Day03.parse_input(input)
      parts_numbers = Day03.find_parts_numbers(input)
      gear_ratios = []

      lines.each_with_index do |line, y|
        line.chars.each_with_index do |char, x|
          next unless char.match?(/\*/)

          start = x
          finish = x
          Location.new(char, start, finish, y).tap do |loc|
            numbers = loc.perimeter(width, height)
              .select { |x, y| lines[y][x].match?(/[0-9]/) }
              .map { |x, y| parts_numbers[y].filter { |n| x >= n.start && x <= n.finish } }
              .flatten.uniq
            gear_ratios << numbers.map(&:value).inject(:*) if numbers.length == 2
          end
        end
      end
      gear_ratios.sum
    end
  end

  class << self
    def parse_input(input)
      lines = input.split("\n")
      width = lines.first.length - 1
      height = lines.length - 1
      [lines, width, height]
    end

    def find_parts_numbers(input)
      numbers = []
      lines, width, height = Day03.parse_input(input)

      lines.each_with_index do |line, y|
        number_buffer = ""
        line.chars.each_with_index do |char, x|
          number_buffer += char if char.match?(/[0-9]/)

          if char.match?(/[^0-9]/) || x == width
            if number_buffer.length > 0
              finish = x - 1
              start = finish - (number_buffer.length - 1)
              Location.new(number_buffer.to_i, start, finish, y).tap do |loc|
                loc.perimeter(width, height).each do |px, py|
                  if lines[py][px].match?(/[^0-9\.]/)
                    numbers[y] ||= []
                    numbers[y] << loc
                    break
                  end
                end
              end
              number_buffer = ""
            end
          end
        end
      end
      numbers
    end
  end

  private

  class Location
    attr_reader :value, :start, :finish, :y

    def initialize(value, start, finish, y)
      @value = value
      @start = start
      @finish = finish
      @y = y
    end

    def perimeter(width, height)
      @perimeter ||= begin
        left = [0, start - 1].max
        right = [width, finish + 1].min
        bounds = []
        bounds << [left, y] unless left == 0
        bounds << [right, y] unless right == width
        (left..right).each { |x| bounds << [x, y - 1] } if y > 0
        (left..right).each { |x| bounds << [x, y + 1] } if y < height
        bounds
      end
    end
  end
end

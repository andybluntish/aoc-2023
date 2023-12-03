#!/usr/bin/env ruby -w

module Day3
  module Part1
    def self.run(input)
      Day3.find_parts_numbers(input).flatten.compact.map(&:number).sum
    end
  end

  module Part2
    def self.run(input)
      parts_numbers = Day3.find_parts_numbers(input)
      gear_ratios = []
      grid = input.split("\n")
      width = grid.first.length - 1
      height = grid.length - 1

      grid.each_with_index do |line, y|
        line.chars.each_with_index do |char, x|
          next unless char.match?(/\*/)

          start = x - 1
          finish = x + 1
          left = [0, start].max
          right = [width, finish].min

          bounds = []
          bounds << [left, y] unless left == 0
          bounds << [right, y] unless right == width
          (left..right).each { |x| bounds << [x, y - 1] } if y > 0
          (left..right).each { |x| bounds << [x, y + 1] } if y < height

          numbers = bounds
            .select { |x, y| grid[y][x].match?(/[0-9]/) }
            .map { |x, y| parts_numbers[y].filter { |n| x >= n.start && x <= n.finish } }
            .flatten.uniq
          gear_ratios << numbers.map(&:number).inject(:*) if numbers.length == 2
        end
      end
      gear_ratios.sum
    end
  end

  class << self
    def find_parts_numbers(input)
      numbers = []

      grid = input.split("\n")
      width = grid.first.length - 1
      height = grid.length - 1

      grid.each_with_index do |line, y|
        number_buffer = ""
        line.chars.each_with_index do |char, x|
          if char.match?(/[0-9]/)
            number_buffer += char
          end

          if char.match?(/[^0-9]/) || x == line.length - 1
            if number_buffer.length > 0
              finish = x - 1
              start = x - number_buffer.length
              left = [0, start - 1].max
              right = [width, finish + 1].min
              bounds = []
              bounds << [left, y] unless left == 0
              bounds << [right, y] unless right == width
              (left..right).each { |x| bounds << [x, y - 1] } if y > 0
              (left..right).each { |x| bounds << [x, y + 1] } if y < height

              bounds.each do |point|
                if grid[point[1]][point[0]].match?(/[^0-9\.]/)
                  numbers[y] ||= []
                  numbers[y] << PartsNumber.new(number_buffer.to_i, start, y)
                  break
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

  class PartsNumber
    attr_reader :number, :start, :finish, :y

    def initialize(number, start, y)
      @number = number
      @start = start
      @finish = start + number.to_s.length - 1
      @y = y
    end
  end
end

if __FILE__ == $0
  input = File.read(File.join(__dir__, "input.txt"))
  puts Day3::Part1.run(input)
  puts Day3::Part2.run(input)
end

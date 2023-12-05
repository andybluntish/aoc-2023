#!/usr/bin/env ruby -w
require "debug"

module Day05
  module Part1
    def self.run(input)
      seeds, maps = Day05.parse(input)
      locations = seeds.map do |seed|
        maps.each do |map|
          range = map.find { |m| m[:src].include?(seed) }
          seed = range[:dest].min + (seed - range[:src].min) if range
        end
        seed
      end

      locations.min
    end
  end

  module Part2
    def self.run(input)
    end
  end

  class << self
    def parse(input)
      data = input.sub("seeds: ", "seeds:\n").split("\n\n").map do |section|
        section.split("\n").map do |line|
          line.scan(/\d+/).flatten.map(&:to_i)
        end.reject(&:empty?)
      end

      seeds = data.shift.flatten
      maps = data.map do |section|
        section.map do |line|
          {
            src: (line[1]...line[1] + line[2]),
            dest: (line[0]...line[0] + line[2])
          }
        end
      end

      [seeds, maps]
    end
  end
end

#!/usr/bin/env ruby -w
require_relative "lib"

input = File.read(File.join(__dir__, "input.txt"))

puts "Day 03"
puts "--------------------"
puts "Part 1: #{Day03::Part1.run(input)}"
puts "Part 2: #{Day03::Part2.run(input)}"

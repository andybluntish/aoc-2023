#!/usr/bin/env ruby -w
require_relative "lib"

input = File.read(File.join(__dir__, "input.txt"))

puts "Day 05"
puts "--------------------"
puts "Part 1: #{Day05::Part1.run(input)}"
puts "Part 2: #{Day05::Part2.run(input)}"

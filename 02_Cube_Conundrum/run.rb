#!/usr/bin/env ruby -w
require_relative "lib"

input = File.read(File.join(__dir__, "input.txt"))

puts "Day 02"
puts "--------------------"
puts "Part 1: #{Day02::Part1.run(input)}"
puts "Part 2: #{Day02::Part2.run(input)}"

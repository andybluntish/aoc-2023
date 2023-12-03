#!/usr/bin/env ruby -w

require "minitest/autorun"
require_relative "day_2"

INPUT = <<~INPUT
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
INPUT

class Part1Test < Minitest::Test
  def test_example_input
    assert_equal 8, Day2::Part1.run(INPUT)
  end

  def test_input
    input = File.read(File.join(__dir__, "input.txt"))

    assert_equal 2204, Day2::Part1.run(input)
  end
end

class Part2Test < Minitest::Test
  def test_example_input
    assert_equal 2286, Day2::Part2.run(INPUT)
  end

  def test_input
    input = File.read(File.join(__dir__, "input.txt"))

    assert_equal Day2::Part2.run(input), 71036
  end
end

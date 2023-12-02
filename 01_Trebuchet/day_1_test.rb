#!/usr/bin/env ruby -w

require "minitest/autorun"
require_relative "day_1"

class Part1Test < Minitest::Test
  def test_example_input
    input = <<~INPUT
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    INPUT

    assert_equal 142, Day1::Part1.run(input)
  end

  def test_input
    input = File.read(File.join(__dir__, "input.txt"))
    assert_equal 54644, Day1::Part1.run(input)
  end
end

class Part2Test < Minitest::Test
  def test_example_input
    input = <<~INPUT
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    INPUT

    assert_equal 281, Day1::Part2.run(input)
  end

  def test_input
    input = File.read(File.join(__dir__, "input.txt"))
    assert_equal Day1::Part2.run(input), 53348
  end
end

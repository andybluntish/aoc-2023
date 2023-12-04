#!/usr/bin/env ruby -w

require "minitest/autorun"
require_relative "lib"

INPUT = <<~INPUT
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
INPUT

class Part1Test < Minitest::Test
  def test_example_input
    assert_equal 4361, Day03::Part1.run(INPUT)
  end

  def test_real_input
    input = File.read(File.join(__dir__, "input.txt"))
    assert_equal 535351, Day03::Part1.run(input)
  end
end

class Part2Test < Minitest::Test
  def test_example_input
    assert_equal 467835, Day03::Part2.run(INPUT)
  end

  def test_real_input
    input = File.read(File.join(__dir__, "input.txt"))
    assert_equal Day03::Part2.run(input), 87287096
  end
end

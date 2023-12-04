#!/usr/bin/env ruby -w

require "fileutils"

def lib_contents(day)
  <<~EOS
    #!/usr/bin/env ruby -w

    module Day#{day}
      module Part1
        def self.run(input)
        end
      end

      module Part2
        def self.run(input)
        end
      end
    end
  EOS
end

def run_contents(day)
  <<~EOS
    #!/usr/bin/env ruby -w
    require_relative "lib"

    input = File.read(File.join(__dir__, "input.txt"))

    puts "Day #{day}"
    puts "--------------------"
    puts "Part 1: \#{Day#{day}::Part1.run(input)}"
    puts "Part 2: \#{Day#{day}::Part2.run(input)}"
  EOS
end

def test_contents(day)
  <<~EOS
    #!/usr/bin/env ruby -w

    require "minitest/autorun"
    require_relative "lib"

    INPUT = <<~INPUT
    INPUT

    class Part1Test < Minitest::Test
      def test_example_input
        assert_equal "XXX", Day#{day}::Part1.run(INPUT)
      end

      # def test_real_input
      #   input = File.read(File.join(__dir__, "input.txt"))
      #   assert_equal "XXX", Day#{day}::Part1.run(input)
      # end
    end

    class Part2Test < Minitest::Test
      # def test_example_input
      #   assert_equal "XXX", Day#{day}::Part2.run(INPUT)
      # end

      # def test_real_input
      #   input = File.read(File.join(__dir__, "input.txt"))
      #   assert_equal "XXX", Day#{day}::Part2.run(input)
      # end
    end
  EOS
end

day = ARGV[0].to_s.rjust(2, "0")
name = ARGV[1..].join(" ").split(/\s+/).map(&:capitalize).join("_")
path = File.join(__dir__, "..", "#{day}_#{name}")

unless File.directory?(path)
  FileUtils.mkdir_p(path)
  {
    "lib.rb" => lib_contents(day),
    "run.rb" => run_contents(day),
    "test.rb" => test_contents(day),
    "input.txt" => ""
  }.each do |filename, contents|
    File.write(File.join(path, filename), contents)
  end
end

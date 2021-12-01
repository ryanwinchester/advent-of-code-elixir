defmodule Advent2020.Day10Test do
  use Advent.FileCase

  alias Advent2020.Day10

  doctest Day10

  test "Part 1 - input file" do
    input = load_file_lines(2020, "day-10")
    assert Day10.part_1(input) == 2100
  end

  test "Part 2 - input file" do
    input = load_file_lines(2020, "day-10")
    assert Day10.part_2(input) == 16_198_260_678_656
  end
end

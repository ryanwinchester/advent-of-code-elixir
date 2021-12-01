defmodule Advent2020.Day09Test do
  use Advent.FileCase

  alias Advent2020.Day09

  doctest Day09

  test "Part 1 - input file" do
    input = load_file_lines(2020, "day-09")
    assert Day09.part_1(input) == 14_360_655
  end

  test "Part 2 - input file" do
    input = load_file_lines(2020, "day-09")
    assert Day09.part_2(input) == 1_962_331
  end
end

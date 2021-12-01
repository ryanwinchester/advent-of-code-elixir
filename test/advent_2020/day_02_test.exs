defmodule Advent2020.Day02Test do
  use Advent.FileCase

  alias Advent2020.Day02

  doctest Day02

  test "Part 1 - input file" do
    input = load_file_lines(2020, "day-02")
    assert Day02.part_1(input) == 524
  end

  test "Part 2 - input file" do
    input = load_file_lines(2020, "day-02")
    assert Day02.part_2(input) == 485
  end
end

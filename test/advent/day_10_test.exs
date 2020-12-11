defmodule Advent.Day10Test do
  use Advent.FileCase

  alias Advent.Day10

  doctest Day10

  test "Part 1 - input file" do
    input = load_file_lines("day-10")
    assert Day10.part_1(input) == 2100
  end

  test "Part 2 - input file" do
    input = load_file_lines("day-10")
    assert Day10.part_2(input) == 16198260678656
  end
end

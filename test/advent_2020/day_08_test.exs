defmodule Advent2020.Day08Test do
  use Advent.FileCase

  alias Advent2020.Day08

  doctest Day08

  test "Part 1 - input file" do
    input = load_file_lines(2020, "day-08")
    assert Day08.part_1(input) == 2080
  end

  test "Part 2 - input file" do
    input = load_file_lines(2020, "day-08")
    assert Day08.part_2(input) == 2477
  end
end

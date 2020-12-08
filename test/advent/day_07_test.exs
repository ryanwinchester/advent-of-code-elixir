defmodule Advent.Day07Test do
  use Advent.FileCase

  alias Advent.Day07

  doctest Day07

  test "Part 1 - input file" do
    input = load_file_lines("day-07")
    assert Day07.part_1(input) == 335
  end

  test "Part 2 - input file" do
    input = load_file_lines("day-07")
    assert Day07.part_2(input) == 2431
  end
end

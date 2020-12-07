defmodule Advent.Day03Test do
  use Advent.FileCase

  alias Advent.Day03

  doctest Day03

  test "Part 1 - input file" do
    input = load_file_lines("day-03")
    assert Day03.part_1(input) == 148
  end

  test "Part 2 - input file" do
    input = load_file_lines("day-03")
    assert Day03.part_2(input) == 727_923_200
  end
end

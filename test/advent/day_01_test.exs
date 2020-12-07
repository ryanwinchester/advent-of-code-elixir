defmodule Advent.Day01Test do
  use Advent.FileCase

  alias Advent.Day01

  doctest Day01

  test "Part 1 - input file" do
    input = Enum.map(load_file_lines("day-01"), &String.to_integer/1)
    assert Day01.part_1(input) == 1_015_476
  end

  test "Part 2 - input file" do
    input = Enum.map(load_file_lines("day-01"), &String.to_integer/1)
    assert Day01.part_2(input) == 200_878_544
  end
end

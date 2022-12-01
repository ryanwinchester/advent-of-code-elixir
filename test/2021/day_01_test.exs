defmodule Advent2021.Day01Test do
  use Advent.FileCase

  alias Advent2021.Day01

  doctest Day01

  setup do
    input = load_file_lines_to_integer(2021, "day-01")
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Day01.part_1(input) == 1564
  end

  test "Part 2 - input file", %{input: input} do
    assert Day01.part_2(input) == 1611
  end
end
